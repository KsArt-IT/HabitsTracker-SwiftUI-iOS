//
//  BackgroundButton.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import SwiftUI

struct PrimaryButton: View {
    let label: LocalizedStringKey
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .foregroundStyle(Color.textInvert)
        }
        .disabled(disabled)
        .frame(maxWidth: .infinity, maxHeight: Constants.Sizes.bottomHeight)
        .background(Color.buttonBackground)
        .clipShape(RoundedRectangle(cornerRadius: Constants.Sizes.bottomCornerRadius))
    }
}

#Preview {
    PrimaryButton(label: "Continue", disabled: false, action: {})
}
