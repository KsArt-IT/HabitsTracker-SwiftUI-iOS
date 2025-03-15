//
//  RadialGradientBackground.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import SwiftUI

fileprivate struct RadialGradientBackground: ViewModifier {
    let center: UnitPoint
    let startRadius: CGFloat
    let endRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                RadialGradient(
                    colors: [.brandBackground, .brandGray],
                    center: center,
                    startRadius: startRadius,
                    endRadius: endRadius
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            }
    }
}

// Расширение для удобного использования модификатора
extension View {
    func radialGradientBackground(center: UnitPoint = .top, startRadius: CGFloat, endRadius: CGFloat) -> some View {
        self.modifier(
            RadialGradientBackground(
                center: center,
                startRadius: startRadius,
                endRadius: endRadius
            )
        )
    }
}
