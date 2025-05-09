//
//  RadialGradientBackground.swift
//  HabitsTracker
//
//  Created by KsArT on 09.05.2025.
//

import SwiftUI

fileprivate struct RadialGradientExBackground: ViewModifier {
    let endRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: Constants.Sizes.habitCornerRadius)
                    .fill(
                        RadialGradient(
                            colors: [.formBackground, .formBackground.opacity(0.5)],
                            center: .topTrailing,
                            startRadius: .zero,
                            endRadius: endRadius
                        )
                    )
            }
    }
}

// Расширение для удобного использования модификатора
extension View {
    func radialGradientBackground(endRadius: CGFloat) -> some View {
        self.modifier(
            RadialGradientExBackground(endRadius: endRadius)
        )
    }
}
