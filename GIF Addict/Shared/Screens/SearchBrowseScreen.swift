import Addiction
import SwiftUI

struct SearchBrowseScreen<Session: SessionCoordination & ObservableObject>: View {

    @StateObject var session: Session
    @State private var didAppear = 0

    var body: some View {
        ZStack {
            Color.addictPurple1.edgesIgnoringSafeArea(.all)

            Color.addictFavoritesBackground.opacity(0.5)
                .clipShape(Circle())
                .scaleEffect(session.contentSource == .favorites ? 5 : 0.01)
                .position(.zero)
                .opacity(session.contentSource == .favorites ? 1 : 0)

            mainScreen
                .scaleEffect(didAppear > 2 ? 1 : 0.5)
                .opacity(didAppear > 2 ? 1 : 0)

            SplashScreen(didAppear: didAppear)
        }
        .animate(.spring(), didAppear)
        .animate(.spring(), session.contentSource)
        .onAppear(perform: splashAnimation)
        .onAppear(perform: session.onAppear)
    }

    @Namespace private var sharedNamespace
    private var mainScreen: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 30) {
                TopBarLayout(size: geo.size, session: session)
                    .zIndex(2) // Ensures text animation is on top of the grid

                if session.isResettingContentSource {
                    Spacer()
                } else {
                    ContentGrid(browser: session.browser, geometry: geo)
                }
            }
            .overlay(FocusedContentScreen(rater: session.rater))
            .environment(\.focusedContent, focus)
            .environment(\.namespace, sharedNamespace)
        }
    }
}

extension SearchBrowseScreen {

    struct TopBarLayout<Session: SessionCoordination & ObservableObject>: View {

        var size: CGSize
        @ObservedObject var session: Session

        var body: some View {
            HStack(alignment: .center) {

                FavoritesButton(action: session.toggleFavorites, isOn: session.contentSource == .favorites)
                    .alignmentGuide(VerticalAlignment.center) { $0[.firstTextBaseline] - alignmentOffset }

                VStack(alignment: .center, spacing: 15) {
                    SearchBar(height: size.height, query: session.query)
                    ContentGridControls(browser: session.browser)
                        .padding(.horizontal, 30)
                }
                .frame(width: size.width * 0.5)
                .frame(maxWidth: .infinity, alignment: .center)

                SharePlayButton(vm: .init(session: session))
                    .alignmentGuide(VerticalAlignment.center) { $0[.firstTextBaseline] - alignmentOffset }
            }
            .padding(.horizontal, 60)
            .padding(.top, 20)
        }

        private let alignmentOffset = CGFloat(8)
    }
}

extension SearchBrowseScreen {

    private var focus: Binding<AddictiveContent?> {
        Binding(
            get: { [weak session] in session?.rater.content },
            set: { [weak session] newState in
                let transaction = Transaction(animation: .spring().speed(2))
                withTransaction(transaction) {
                    session?.userSetFocus(to: newState)
                }
            }
        )
    }

    private func splashAnimation() {
        didAppear += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            didAppear += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            didAppear += 1
        }
    }
}

extension SessionCoordination {

    func toggleFavorites() {
        let next = self.contentSource == .favorites ? ContentServiceChoices.remote : .favorites
        self.userSetContentSource(to: next)
    }
}
