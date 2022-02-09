// Copyright 2022 Ryan Ferrell

import SwiftUI

public enum Local: String {
    case appTitle = "APP_TITLE"
    case searchPrompt = "SEARCH_PROMPT"
    case results = "LABEL_RESULTS"
    case scrollToTop = "LABEL_SCROLLTOTOP"
    case sharePlay = "LABEL_SHAREPLAY"
    case sharePlayDisconnect = "LABEL_SHAREPLAYDISCONNECT"
    case favorites = "LABEL_FAVORITES"
    case byRating = "LABEL_SORT_BYRATING"
    case untitled = "TITLE_UNTITLED"
    case created = "LABEL_CREATED"
    case trended = "LABEL_TRENDED"
    case instantly = "LABEL_INSTANTLY"

    public var key: LocalizedStringKey { .init(rawValue) }
}
