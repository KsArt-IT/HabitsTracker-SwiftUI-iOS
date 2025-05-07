//
//  NavTitleView.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct NavTitleView: View {
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(systemName: "arrow.backward")
                    .font(.system(size: Constants.Sizes.icon))
                    .frame(width: Constants.Sizes.large, height: Constants.Sizes.large)
                    .foregroundStyle(Color.text)
                    .background(Color.tabBackground)
                    .clipShape(Capsule(style: .circular))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavTitleView(action: {})
}
