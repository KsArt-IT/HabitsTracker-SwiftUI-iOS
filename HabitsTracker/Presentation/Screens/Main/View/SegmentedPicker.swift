//
//  SplashScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import SwiftUI

struct SegmentedView: View {
    @Namespace private var namespace

    @Binding var selection: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    withAnimation(.spring(duration)) {
                        selection = tab
                    }
                } label: {
                    Text(tab.rawValue)
                        .font(Constants.Fonts.appTab)
                        .padding(.vertical, Constants.Sizes.small)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selection == tab ? Color.white : Color.primary)
                }
                .background {
                    if selection == tab {
                        Capsule()
                            .fill(.black)
                            .matchedGeometryEffect(id: Constants.Namespace.appTab, in: namespace)
                    }
                }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.1))
        .clipShape(Capsule())
    }
    
}
