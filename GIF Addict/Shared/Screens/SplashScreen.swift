// Copyright 2022 Ryan Ferrell

import SwiftUI

struct SplashScreen: View {

    var didAppear: Int

    var body: some View {
        HStack {
            if didAppear == 1 || didAppear == 2 { gAnimation }
            if didAppear == 1 || didAppear == 2 { iAnimation }
            if didAppear == 1 || didAppear == 2 { fAnimation }
        }
        .font(.gilbert(size: 500))
        .overlay(addictAnimation, alignment: .bottom)
        .frame(minWidth: 600, minHeight: 400)
        .animate(.spring(), didAppear)
        .allowsHitTesting(false)
    }

    private var gAnimation: some View {
        Text("G")
            .transition(
                .asymmetric(
                    insertion: .scale(scale: 0.05, anchor: .leading).combined(with: .move(edge: .leading)),
                    removal: .scale(scale: 0.05, anchor: .trailing).combined(with: .move(edge: .trailing))
                ).combined(with: .opacity).animation(.spring().delay(0.1))
            )
            .rotationEffect(didAppear == 2 ? .degrees(50) : .degrees(0))
            .hueRotation(didAppear == 1 ? .degrees(180) : .zero)
            .frame(maxWidth: .infinity)
    }

    private var iAnimation: some View {
        Text("I")
            .transition(
                .asymmetric(
                    insertion: .scale(scale: 0.05, anchor: .bottom).combined(with: .move(edge: .bottom)),
                    removal: .scale(scale: 0.05, anchor: .top).combined(with: .move(edge: .top))
                ).combined(with: .opacity)
            )
            .hueRotation(didAppear == 1 ? .degrees(180) : .zero)
            .rotationEffect(didAppear == 2 ? .degrees(-50) : .degrees(0))
            .frame(maxWidth: .infinity)
    }

    private var fAnimation: some View {
        Text("F")
            .transition(
                .asymmetric(
                    insertion: .scale(scale: 0.05, anchor: .trailing).combined(with: .move(edge: .trailing)),
                    removal: .scale(scale: 0.05, anchor: .leading).combined(with: .move(edge: .leading))
                ).combined(with: .opacity).animation(.spring().delay(0.2))
            )
            .rotationEffect(didAppear == 2 ? .degrees(50) : .degrees(0))
            .hueRotation(didAppear == 1 ? .zero : .degrees(180))
            .frame(maxWidth: .infinity)
    }

    @ViewBuilder private var addictAnimation: some View {
        if didAppear == 1 || didAppear == 2 {
            Text("ADDICT")
                .font(.gilbert(size: 125))
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}
