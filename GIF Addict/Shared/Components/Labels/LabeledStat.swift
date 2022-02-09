// Copyright 2022 Ryan Ferrell

import SwiftUI

struct LabeledStat: View {

    let label: LocalizedStringKey
    let stat: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Text(stat)
                .foregroundColor(.primary)
        }
    }
}

struct LabeledStringStat: View {

    let label: String
    let stat: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Text(stat)
                .foregroundColor(.primary)
        }
    }
}

struct LabeledStatURL: View {

    let label: LocalizedStringKey
    let stat: String
    let url: URL

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Link(stat, destination: url)
        }
    }
}
