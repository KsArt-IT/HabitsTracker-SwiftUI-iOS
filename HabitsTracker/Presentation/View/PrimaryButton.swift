//
//  BackgroundButton.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import SwiftUI

struct PrimaryButton: View {
    let label: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .foregroundStyle(Color.textInvert)
        }
        .frame(maxWidth: .infinity, maxHeight: Constants.Sizes.bottomHeight)
        .frame(width: .infinity, height: Constants.Sizes.bottomHeight)
        .backgroundStyle(Color.buttonBackground)
        .clipShape(RoundedRectangle(cornerRadius: Constants.Sizes.bottomCornerRadius))
    }
}

#Preview {
    PrimaryButton(label: "", action: {})
}
