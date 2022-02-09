import Foundation
import SwiftUI
import CoreData

public class AddictiveCoreDataService {

    let stack: StackManager
    let context: NSManagedObjectContext
    let isBackground: Bool

    public init(coreDataStack: StackManager, useBackgroundContext: Bool) {
        self.isBackground = useBackgroundContext
        self.stack = coreDataStack
        self.context = useBackgroundContext ? stack.newBackgroundContext() : stack.viewContext
        self.context.name = useBackgroundContext ? "Background" : "Main"
    }
}

// MARK: - Public API

extension AddictiveCoreDataService: AddictiveCoreDataContentService {

    /// Adds new content (or, if existing, updates its rating)
    ///
    public func persist(content: AddictiveCoreDataContent) {
        if let existing = fetch(byHostIDs: [content.hostID], limit: 1).first {
            existing.updating(ratingFrom: content)
        } else {
            let _ = content.convertToCoreDataMO(in: context)
        }
        stack.save(toMain: context)
    }

    /// Adds a batch of new content
    ///
    public func persist(newContent: [AddictiveCoreDataContent]) {
        let _ = newContent.map { $0.convertToCoreDataMO(in: context) }
        stack.save(toMain: context)
    }

    /// Deletes targeted content by identifier
    ///
    public func delete(content: AddictiveCoreDataContent) {
        let existingRecords: [ContentMO] = fetch(byHostIDs: [content.hostID], limit: nil)
        existingRecords.forEach {
            context.delete($0)
        }
        stack.save(toMain: context)
    }

    /// Finds content matching
    ///
    public func fetch(query: AddictiveCoreDataSearchQuery) -> AddictiveCoreDataSearchResult {
        var request = ContentMO.fetchRequest()
        request.fetchOffset = query.offset
        request.fetchBatchSize = query.batchLimit ?? 0
        if query.query.isEmpty == false {
            let predicate = NSPredicate(format: "title CONTAINS[c] %@", query.query)
            request.predicate = predicate
        }
        sortByRatingThenDate(request: &request)

        let results: [ContentMO] = perform(fetch: request)
        let totalPossibleResults = results.endIndex

        let batch = slice(
            withoutFaulting: results[...],
            from: query.offset,
            to: query.batchLimit ?? results.endIndex
        ).map(AddictiveCoreDataContent.init(mo:))

        return .init(results: batch, offset: query.offset, totalResults: totalPossibleResults)
    }

    /// Returns content whose ids match the targets
    ///
    public func fetch(contentServiceIDs: [AddictiveCoreDataContent.ServiceIdentifier]) -> AddictiveCoreDataSearchResult {
        let results = fetch(byHostIDs: contentServiceIDs, limit: contentServiceIDs.endIndex)
            .map(AddictiveCoreDataContent.init(mo:))
        return .init(results: results, offset: 0, totalResults: results.endIndex)
    }

    /// Returns all stored content
    ///
    public func fetchAllContent() -> AddictiveCoreDataSearchResult {
        var request = ContentMO.fetchRequest()
        sortByRatingThenDate(request: &request)
        let results: [AddictiveCoreDataContent] = perform(fetch: request)
        return .init(results: results, offset: 0, totalResults: results.endIndex)
    }

}

// MARK: - Internal Helpers

internal extension AddictiveCoreDataService {

    /// Slice the results per requested batch size and starting point
    ///
    func slice(
        withoutFaulting results: ArraySlice<ContentMO>,
        from start: Int,
        to batchLimit: Int
    ) -> ArraySlice<ContentMO> {

        let start = max(0, start)
        let endLimit = min(batchLimit, results.endIndex)
        let end = min(endLimit &+ start, results.endIndex)
        guard start <= end else { return [] }
        return results.dropFirst(start)[..<end]
    }

    /// Add default sorting to a FetchRequest
    ///
    func sortByRatingThenDate(request: inout NSFetchRequest<ContentMO>) {
        let byRating = NSSortDescriptor(keyPath: \ContentMO.rating, ascending: false)
        let byTitle = NSSortDescriptor(keyPath: \ContentMO.title, ascending: true)
        request.sortDescriptors = [byRating, byTitle]
    }

    /// Find saved records matching a hostID
    ///
    func fetch(byHostIDs: [AddictiveCoreDataContent.ServiceIdentifier], limit: Int?) -> [ContentMO] {
        var request = ContentMO.fetchRequest()
        if let limit = limit {
            request.fetchLimit = limit
        }
        let predicate = NSPredicate(format: "hostID IN %@", byHostIDs)
        request.predicate = predicate
        sortByRatingThenDate(request: &request)
        return perform(fetch: request)
    }

    /// Perform a fetch request with a public output
    ///
    func perform(fetch request: NSFetchRequest<ContentMO>) -> [AddictiveCoreDataContent] {
        perform(fetch: request).map(AddictiveCoreDataContent.init(mo:))
    }

    /// Perform a fetch request with a CoreData output
    ///
    func perform(fetch request: NSFetchRequest<ContentMO>) -> [ContentMO] {
        do {
            return try context.fetch(request)
        } catch let error as NSError {
            fatalError("\(Self.self): \(error)  \(error.userInfo)")
        }
    }
}
