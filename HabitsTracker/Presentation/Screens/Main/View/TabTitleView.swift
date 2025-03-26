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
            Spacer()
            Button {
                action()
            } label: {
                Image("add")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.text)
            }
            .padding(Constants.Sizes.appTabPaddingVertical)
            .background(Color.tabBackground)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    TabTitleView(title: "Name", action: {})
}
