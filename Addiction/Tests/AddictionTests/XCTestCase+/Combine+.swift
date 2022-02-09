import Combine
import XCTest

public extension XCTestCase {

    typealias ExpectedCompletion<P: Publisher> = (
        _ exp: XCTestExpectation,
        _ completion: Subscribers.Completion<P.Failure>
    ) -> Void

    typealias ExpectedValue<P: Publisher> = (
        _ exp: XCTestExpectation,
        _ value: P.Output
    ) -> Void

    /// Nil count for inverted. Calls fulfill on completion and after receiveValue.
    func awaitPublisher<P: Publisher>(
        _ publisher: P,
        count: Int? = 1,
        timeout: TimeInterval = 1,
        trigger: @escaping () -> Void,
        receiveCompletion: @escaping ExpectedCompletion<P> = { exp, _ in exp.fulfill() },
        receiveValue: @escaping ExpectedValue<P> = { _,_ in }
    ) {
        var subs = Set<AnyCancellable>()
        let exp = XCTestExpectation()
        if let count = count {
            exp.expectedFulfillmentCount = count
        } else {
            exp.isInverted = true
        }

        publisher.sink { completion in
            receiveCompletion(exp, completion)
        } receiveValue: { value in
            receiveValue(exp, value)
            exp.fulfill()
        }
        .store(in: &subs)

        trigger()
        wait(for: [exp], timeout: timeout)
    }
}
