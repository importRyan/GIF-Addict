// Copyright 2022 Ryan Ferrell

import Addiction
import SwiftUI

struct SearchBrowseScene: Scene {

    @StateObject var factory: UseCaseFactory

    var body: some Scene {
        WindowGroup(Local.appTitle.key, id: "Main") {
            SearchBrowseScreen(session: factory.createBrowsingSession())
                .environmentObject(factory)
            #if os(macOS)
                .frame(minWidth: 1_200, minHeight: 700)
            #endif
        }
        .commands {
            CommandGroup(replacing: .help) {}
            CommandGroup(replacing: .newItem) {}
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        #endif
    }
}
