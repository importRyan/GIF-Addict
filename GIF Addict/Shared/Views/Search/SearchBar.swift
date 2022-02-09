// Copyright 2022 Ryan Ferrell

import Addiction
import SharedUI
import SwiftUI

struct SearchBar<Query: QueryComposing>: View {
    var height: CGFloat

    @ObservedObject var query: Query

    // Stub until dyslexic font adaptation EnvironmentKey added
    @State var useGilbert = true

    @State private var isHovered = false
    @State private var submitCount = 0
    @FocusState private var textFieldIsFocused: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            SearchButton(action: query.submitQuery)
            field
            ClearButton(action: query.resetQuery, isHidden: query.query.isEmpty)
        }
        .padding(.horizontal, 15)
        .background(background)
    }

    private var field: some View {
        TextField("", text: textFieldBinding)
            .focused($textFieldIsFocused)
            .test(id: .searchTextField)
            .scaleEffect(submitCount.isMultiple(of: 2) ? 1 : 1.2)
            .animate(.spring().speed(1.25), submitCount)
            .textFieldStyle(.plain)
            .disableAutocorrection(true)
            .foregroundColor(.accentColor)
            .font(useGilbert ? .gilbert(size: 70) : .fira(size: 25, weight: .regular, style: .largeTitle))
            .multilineTextAlignment(.center)
            .frame(minHeight: 70)
            .onSubmit(of: .text, submit)
            .background(prompt)
            .overlay(zoomingSubmitTextEffect.animate(.spring(), submitCount))
            .onAppear { textFieldIsFocused = true }
    }

    @ViewBuilder private var zoomingSubmitTextEffect: some View {
        if submitCount.isMultiple(of: 2) == false {
            Text(textFieldBinding.wrappedValue)
                .font(useGilbert ? .gilbert(size: 70) : .fira(size: 25, weight: .regular, style: .largeTitle))
                .multilineTextAlignment(.center)
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.001, anchor: .top).combined(with: .opacity),
                    removal: .scale(scale: 15, anchor: .top).combined(with: .opacity))
                )
        }
    }

    private var prompt: some View {
        Text(Local.searchPrompt.key)
            .font(.fira(size: 25, weight: .regular, style: .largeTitle))
            .foregroundColor(.addictPurple7)
            .opacity(query.query.isEmpty ? 1 : 0)
            .animate(.easeOut(duration: .fast), query.query.isEmpty)
            .test(id: .searchPrompt)
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(isHovered ? Color.addictPurple3 : .addictPurple2)
            .animate(.easeOut(duration: .medium), isHovered)
            .onHover { isHovered = $0 }
            .test(id: .searchBackground)
    }
}

private extension SearchBar {

    func submit() {
        textFieldIsFocused = false
        submitCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            submitCount += 1
        }
        query.submitQuery()
    }

     var textFieldBinding: Binding<String> {
        .init(
            get: { [weak query] in query?.query.uppercased() ?? "" },
            set: { [weak query] in query?.updateQuery(text: $0) }
        )
    }
}
