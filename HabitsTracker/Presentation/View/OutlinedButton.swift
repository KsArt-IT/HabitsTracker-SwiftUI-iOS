//
//  OutlinedButton.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import SwiftUI

struct OutlinedButton: View {
    let label: LocalizedStringKey
    let color: Color
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
                .foregroundStyle(disabled ? .textDisabled : color)
                .background(disabled ? .buttonDisabled : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.Sizes.buttonCornerRadius)
                        .stroke(disabled ? .buttonDisabled : color,lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: Constants.Sizes.buttonCornerRadius))
        }
        .disabled(disabled)
        .opacity(disabled ? Constants.Sizes.buttonDisabledOpacity : 1.0)
    }
}

#Preview {
    OutlinedButton(label: "Continue", color: .red, disabled: false, action: {})
}
