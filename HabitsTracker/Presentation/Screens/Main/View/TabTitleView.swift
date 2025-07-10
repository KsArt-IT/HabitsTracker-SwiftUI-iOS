//
//  TabTitleView.swift
//  HabitsTracker
//
//  Created by KsArT on 26.03.2025.
//

import SwiftUI

struct TabTitleView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(Constants.Fonts.mediumTitle)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer(minLength: Constants.Sizes.medium)
            Button(action: action) {
                Image("PlusSquared")
                    .font(.system(size: Constants.Sizes.icon))
                    .foregroundStyle(Color.text)
            }
            .padding(Constants.Sizes.appTabPaddingVertical)
            .background(Color.tabBackground)
            .clipShape(.circle)
        }
    }
}

#Preview {
    TabTitleView(title: "Name", action: {})
}
