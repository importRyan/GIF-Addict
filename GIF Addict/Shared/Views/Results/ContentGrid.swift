// Copyright 2022 Ryan Ferrell

import Addiction
import NukeUI
import SharedUI
import SwiftUI

struct ContentGrid<Browser: Browsing>: View {

    @ObservedObject var browser: Browser
    var geometry: GeometryProxy

    private var centering: CGFloat {
        let columns = CGFloat.numberOfColumns(forViewWidth: geometry.size.width)
        let contentWidth = Int(CGFloat.standardPreviewItemSize + .standardPreviewItemSpacing) * columns
        let padding = (geometry.size.width - CGFloat(contentWidth)) / 2
        return max(0, padding - 10)
    }

    var body: some View {
        ScrollViewReader { scroller in
            ScrollView(.vertical, showsIndicators: true) {

                GridView(
                    browser: browser,
                    scroller: scroller,
                    columnCount: CGFloat.numberOfColumns(forViewWidth: geometry.size.width)
                )

                footerItems
                    .animate(.default, browser.results)
                    .animate(.default, browser.isLoading)
            }
            .onReceive(browser.scrollTargetID) { target in
                withAnimation {
                    scroller.scrollTo(target, anchor: .top)
                }
            }
        }
        .padding(.leading, centering)
        .padding(.horizontal, 15)
        .animate(.default, centering)
        .keyboardShortcut(.init(.pageUp))
    }

    @ViewBuilder private var footerItems: some View {

        ProgressView()
            .progressViewStyle(.circular)
            .opacity(browser.isLoading ? 1 : 0)
            .padding(.vertical, 30)

        if browser.results.count > 20 {
            GoToTopButton(action: { browser.scroll(to: browser.results.first?.id ?? "") })
                .padding(.vertical, 40)
        }
    }
}

extension ContentGrid {

    struct GridView: View {

        @ObservedObject var browser: Browser
        var scroller: ScrollViewProxy
        var columnCount: Int

        var body: some View {
            LazyVGrid(
                columns: Array(repeating: gridItem, count: columnCount),
                alignment: .leading,
                spacing: .standardPreviewItemSpacing
            ) {
                ForEach(browser.results) { result in
                    ContentGridCell(content: result)
                        .frame(width: .standardPreviewItemSize, height: .standardPreviewItemSize)
                        .onAppear { browser.cellDidAppear(for: result.id) }
                        .onDisappear { browser.cellDidDisappear(for: result.id) }
                }.test(id: .searchResultPreviewGIF)
            }
            .animate(.default, browser.results)
            .animate(.default, columnCount)
        }

        private var gridItem: GridItem {
            GridItem(.fixed(.standardPreviewItemSize), spacing: .standardPreviewItemSpacing, alignment: .leading)
        }
    }
}

private extension CGFloat {

     static func numberOfColumns(forViewWidth: CGFloat) -> Int {
        let approximateWindowWidth = forViewWidth - (.standardPreviewItemSpacing + 40)
        let cellWidth = CGFloat.standardPreviewItemSize + .standardPreviewItemSpacing
        return approximateWindowWidth >= cellWidth * 4 ? 4 : 3
    }
}
