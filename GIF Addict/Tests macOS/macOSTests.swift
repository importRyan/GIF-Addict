import XCTest

/// Example UI tests. Could go more black box to track overloads
/// like panning up and down a 10,000 GIF scroll view.
///
class MacOSTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        try super.setUpWithError()
    }

    func testMainUIElementsPresent() throws {
        let app = XCUIApplication.fastAnimations()
        app.launch()

        let favoritesButton = app.buttons[.test(.favoritesButton)]
        let searchTextField = app.textFields[.test(.searchTextField)]
        let searchBackground = app.otherElements[.test(.searchBackground)]
        let clearButton = app.buttons[.test(.clearButton)]
        let sharePlayButton = app.buttons[.test(.sharePlayButton)]
        let sortButton = app.buttons[.test(.sortButton)]
        let searchManuallyButton = app.buttons[.test(.searchIcon)]
        let searchPrompt = app.staticTexts[.test(.searchPrompt)]

        XCTAssert(favoritesButton.waitFor())
        XCTAssert(clearButton.exists)
        XCTAssert(sharePlayButton.exists)
        XCTAssert(searchManuallyButton.exists)
        XCTAssert(searchTextField.exists)
        XCTAssert(searchBackground.exists)
        XCTAssert(searchPrompt.exists)
        XCTAssertFalse(sortButton.exists)
        let searchIsFocused = searchTextField.value(forKey: "hasKeyboardFocus") as? Bool
        XCTAssertTrue(searchIsFocused ?? false)
    }

    func testLocalizedStringsRendered_EnglishLocalization() throws {
        let app = XCUIApplication.fastAnimations()
        app.launch()

        let searchPrompt = app.staticTexts[.test(.searchPrompt)]
        XCTAssert(searchPrompt.waitFor())
        XCTAssertEqual(searchPrompt.value as? String, "Search GIPHY")
    }

    func testSearchResultsLoadIntoCollectionView() throws {
        let app = XCUIApplication.fastAnimations()
        app.launch()

        let searchTextField = app.textFields[.test(.searchTextField)]
        XCTAssert(searchTextField.waitFor())
        searchTextField.typeText("puppy")
        wait(for: [.inverted()], timeout: 1)

        let resultsCountLabel = app.staticTexts[.test(.searchResultsCount)].value
        let stringValue = resultsCountLabel as? String ?? "0"
        let intValue = Int(stringValue) ?? 0
        XCTAssertGreaterThan(intValue, 1_000)
    }
}
