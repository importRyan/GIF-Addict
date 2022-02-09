import Foundation
import XCTest
import Combine

extension XCTest {

    /// Tolerates query item  reordering
    func AssertURLsEquivalent(
        exp: URL, _ result: URL,
        file: StaticString = #file, line: UInt = #line
    ) {
        XCTAssertEqual(exp.scheme, result.scheme)
        XCTAssertEqual(exp.host, result.host)
        XCTAssertEqual(exp.path, result.path)

        let expQueries = URLComponents(url: exp, resolvingAgainstBaseURL: false)?.queryItems ?? []
        let resultQueries = URLComponents(url: result, resolvingAgainstBaseURL: false)?.queryItems ?? []
        let expSorted = expQueries.sorted(by: { $0.name < $1.name })
        let resultSorted = resultQueries.sorted(by: { $0.name < $1.name })
        XCTAssertEqual(expSorted, resultSorted, file: file, line: line)
    }
}

extension Publisher {

    func sinkAssertNoError(
        completesExp: XCTestExpectation? = nil,
        file: StaticString = #file, line: UInt = #line,
        receiveValue: @escaping (Output) -> Void
    ) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription, file: file, line: line)
            case .finished: break
            }
            completesExp?.fulfill()
        }, receiveValue: receiveValue)
    }
}
