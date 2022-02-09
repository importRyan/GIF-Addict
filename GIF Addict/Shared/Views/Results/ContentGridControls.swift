// Copyright 2022 Ryan Ferrell
import Addiction
import SharedUI
import SwiftUI

struct ContentGridControls<Browser: Browsing>: View {

    @ObservedObject var browser: Browser

    var body: some View {
        HStack {

            SortButton(isAscending: browser.isSortingHighRatingsFirst, didTap: browser.toggleSortOrder)

                .accessibilityHidden(browser.totalResults <= 1)
                .opacity(browser.totalResults <= 1 ? 0 : 1)

            Spacer()

            if browser.totalResults > 0 {
                resultsCountLabel
            }
        }
        .animate(.linear, browser.totalResults)
    }

    private var resultsCountLabel: some View {
        HStack {
            Text(Local.results.key)
                .textCase(.lowercase)
                .foregroundColor(.secondary)

            Text(String(browser.totalResults))
                .font(.fira(size: 15, weight: .medium, style: .footnote))
                .test(id: .searchResultsCount)
        }
    }
}
