// Copyright 2022 Ryan Ferrell

import SharedUI
import SwiftUI

struct PriorQueriesList: View {
    var queries: [String]
    let tappedQuery: (String) -> Void

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                ForEach(queries, id: \.self) { query in
                    Button(query, action: { tappedQuery(query) })
                }
                .font(.fira(size: 22, weight: .medium, style: .largeTitle))
                .buttonStyle(.highlightScale(.addictPurple4, nil))
            }
        }
        .animate(.easeOut(duration: .medium), queries)
    }
}
