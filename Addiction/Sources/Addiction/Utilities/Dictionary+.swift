import Foundation

extension Array {

    /// Uniques keys by the lattermost element in the array.
    ///
    func hashMapBy<H:Hashable>(_ path: KeyPath<Element,H>) -> [H:Element] {
        self.reduce(into: [:]) { dict, element in
            dict[element[keyPath: path]] = element
        }
    }

    /// Uniques keys and indexes by the lattermost element in the array.
    ///
    func hashMapIndexesBy<H:Hashable>(_ path: KeyPath<Element,H>) -> [H:Int] {
        let ids = self.map { $0[keyPath: path] }
        let keyValuePairs = zip(ids, indices).map { ($0, $1) }
        return Dictionary(keyValuePairs, uniquingKeysWith: { _, last in last })
    }
}
