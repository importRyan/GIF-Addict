import Addiction
import AddictiveServices
import NukeUI
import SwiftUI
// MARK: - SwiftUI Main

@main
struct GIFAddictApp: App {

    @StateObject private var root = Root()

    var body: some Scene {
        root.load(services: DevelopmentAppLoader().createServices())
        return SearchBrowseScene(factory: root.makeSceneUseCaseFactory())
    }

#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
#elseif os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
#endif
}

// MARK: - AppDelegate

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationWillFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
        NukeUI.ImagePipeline.setup()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        DispatchQueue.main.async {
            NSApp.windows.forEach { window in
                window.isMovableByWindowBackground = true
            }
        }
    }
}
#endif

#if os(iOS)
class AppDelegate: NSObject, UIApplicationDelegate {

    func applicationDidFinishLaunching(_ application: UIApplication) {
        NukeUI.ImagePipeline.setup()
    }
}
#endif
