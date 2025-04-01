//
//  FormBackgroundView.swift
//  HabitsTracker
//
//  Created by KsArT on 01.04.2025.
//

import SwiftUI

struct FormBackgroundView: ViewModifier  {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: Constants.Sizes.formCornerRadius)
                    .fill(.formBackground)
            }
        
    }
}

extension View {
    func formBackground() -> some View {
        self.modifier(FormBackgroundView())
    }
}
