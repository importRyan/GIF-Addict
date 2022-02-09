// Copyright 2022 Ryan Ferrell
@testable import GIF_Addict
import XCTest

extension XCUIApplication {

    /// Inject launch environment flag for faster animations in SwiftUI
    static func fastAnimations() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchEnvironment["MOTION"] = "FAST"
        return app
    }
}

extension XCUIElement {

    /// Wait for existence with default timeout
    @discardableResult
    func waitFor(_ timeout: Double = 10) -> Bool {
        self.waitForExistence(timeout: timeout)
    }
}

public extension XCUIElement {

    /// Wait for existence and then tap
    func waitTap(_ message: String? = nil, file: StaticString = #file, line: UInt = #line) {
        guard self.waitFor() else {
            XCTFail(message ?? "Not found", file: file, line: line)
            return
        }
        self.tap()
    }
}

extension String {
    static func test(_ id: AccessibilityIdentifier) -> String {
        id.rawValue
    }
}

extension XCTestExpectation {
    static func inverted() -> Self {
        let exp = Self()
        exp.isInverted = true
        return exp
    }
}
