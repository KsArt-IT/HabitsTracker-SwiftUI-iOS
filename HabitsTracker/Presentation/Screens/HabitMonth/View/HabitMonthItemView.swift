//
//  HabitMonthItemView.swift
//  HabitsTracker
//
//  Created by KsArT on 09.05.2025.
//

import SwiftUI

struct HabitMonthItemView: View {
    let status: HabitMonthStatus
    let edit: () -> Void
    let delete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            TitleTextAndMenuView(title: status.title, edit:edit, delete: delete)
                .padding(.top, Constants.Sizes.habitPadding)
                .padding(.leading, Constants.Sizes.habitPaddingLeading)
                .padding(.trailing, Constants.Sizes.habitPadding)
            
            ForEach(Array(status.habitStatus.enumerated()), id: \.offset) { _, status in
                HabitStatusView(weekStatus: status)
            }
            .padding(.horizontal, Constants.Sizes.medium)
            .padding(.bottom, Constants.Sizes.medium)
        }
        .radialGradientBackground(endRadius: 300)
    }
}
