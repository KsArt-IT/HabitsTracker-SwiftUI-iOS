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
                .font(Constants.Fonts.normalMedium)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.Sizes.buttonHeight)
                .foregroundStyle(disabled ? .textDisabled : .textInvert)
                .background(disabled ? .buttonDisabled : .buttonBackground)
                .clipShape(RoundedRectangle(cornerRadius: Constants.Sizes.buttonCornerRadius))
        }
        .disabled(disabled)
        .opacity(disabled ? Constants.Sizes.buttonDisabledOpacity : 1.0)
    }
}

#Preview {
    PrimaryButton(label: "Continue", disabled: false, action: {})
}
