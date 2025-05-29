//
//  IconButtonView.swift
//  HabitsTracker
//
//  Created by KsArT on 17.05.2025.
//

import SwiftUI

struct IconButtonView: View {
    let name: String
    let clear: Bool
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(name)
                .renderingMode(.template)
                .font(.system(size: Constants.Sizes.icon))
                .frame(width: Constants.Sizes.large, height: Constants.Sizes.large)
                .foregroundStyle(disabled ? Color.notCompleted : Color.text)
                .background(clear ? Color.clear : Color.tabBackground)
                .clipShape(Capsule(style: .circular))
        }
        .disabled(disabled)
    }
}

#Preview {
    IconButtonView(name: "chevron.backward", clear: false, disabled: false, action: {})
}
