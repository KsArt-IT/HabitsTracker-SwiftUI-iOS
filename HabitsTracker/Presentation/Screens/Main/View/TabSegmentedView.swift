//
//  SplashScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import SwiftUI

struct TabSegmentedView: View {
    @Namespace private var animation
    
    @Binding var selection: AppTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    withAnimation(.linear(duration: Constants.Times.appTabAnimation)) {
                        selection = tab
                    }
                } label: {
                    Text(tab.rawValue)
                        .padding(.vertical, Constants.Sizes.appTabPaddingVertical)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selection == tab ? .textInvert : .text)
                }
                .background {
                    if selection == tab {
                        Capsule()
                            .fill(.tabSelected)
                            .matchedGeometryEffect(id: Constants.Namespace.appTabGeometryId, in: animation)
                    }
                }
            }
        }
        .font(Constants.Fonts.appTab)
        .padding(Constants.Sizes.tiny)
        .background(Color.tabBackground)
        .clipShape(Capsule())
    }
    
}
