// Copyright 2022 Ryan Ferrell

import Addiction
import SwiftUI

struct SharePlayButtonVM {

    let didTap: () -> Void
    let isReadyToStartNewSession: Bool
    let isActive: Bool
    let image: SFSymbol
    let buttonLabel: LocalizedStringKey

    init<Session: SessionCoordination>(session: Session) {
        self.didTap = session.userToggledSharePlay
        self.isReadyToStartNewSession = session.canCreateGroupSession || session.sharePlaySessionIsActive
        self.isActive = session.sharePlaySessionIsActive
        self.image = .sharePlay
        self.buttonLabel = (session.sharePlaySessionIsActive ? Local.sharePlayDisconnect : Local.sharePlay).key
    }
}
