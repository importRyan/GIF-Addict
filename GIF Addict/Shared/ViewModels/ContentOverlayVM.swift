// Copyright 2022 Ryan Ferrell

import Addiction
import Foundation

struct ContentOverlayVM {

    let title: String
    let sourceLabel: String?

    let showDateCreated: Bool
    var dateCreatedLabel = NSLocalizedString(Local.created.rawValue, comment: "Created")
    var dateCreated = ""

    let showDateTrending: Bool
    let dateTrendingLabel = NSLocalizedString(Local.trended.rawValue, comment: "Trended")
    var dateTrending = ""

    init(content: AddictiveContent, formatter: DateFormatter = yearFormatter) {
        self.title = content.title.isEmpty
        ? NSLocalizedString(Local.untitled.rawValue, comment: "")
        : content.title
        self.sourceLabel = content.sourceLabel.isEmpty ? nil : content.sourceLabel

        // Only show dates if there is a valid, sensical created date
        guard let dateCreated = content.created, dateCreated.timeIntervalSince1970 > 100_000
        else {
            self.showDateCreated = false
            self.showDateTrending = false
            return
        }

        self.showDateCreated = true
        self.dateCreated = formatter.string(from: dateCreated)

        // Only show trended if there is a trending date
        guard let dateTrended = content.trendingDate else {
            self.showDateTrending = false
            return
        }

        self.showDateTrending = true
        self.dateTrending = formatter.string(from: dateTrended)

        // If the same displayed time, use natural language
        if self.dateCreated == self.dateTrending {
            self.dateTrending = NSLocalizedString(Local.instantly.rawValue, comment: "Instantly")
        }
    }
}
