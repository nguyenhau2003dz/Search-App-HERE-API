//
//  SpinningCircleView.swift
//  SearchMap
//
//  Created by Hậu Nguyễn on 23/5/25.
//
import SwiftUI

struct SpinningCircleView: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(Color.gray, lineWidth: 3)
            .frame(width: 20, height: 20)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                .linear(duration: 1).repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

