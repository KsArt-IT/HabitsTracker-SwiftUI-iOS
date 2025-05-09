//
//  HabitItemView.swift
//  HabitsTracker
//
//  Created by KsArT on 08.05.2025.
//

import SwiftUI

struct HabitWeekItemView: View {
    let status: HabitWeekStatus
    let edit: () -> Void
    let delete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            TitleTextAndMenuView(title: status.title, edit:edit, delete: delete)
                .padding(.top, Constants.Sizes.habitPadding)
                .padding(.leading, Constants.Sizes.habitPaddingLeading)
                .padding(.trailing, Constants.Sizes.habitPadding)
            
            WeekDaysView()
                .padding(.bottom, Constants.Sizes.small)
                .padding(.horizontal, Constants.Sizes.medium)
            
            HabitStatusView(weekStatus: status.habitStatus)
                .padding(.horizontal, Constants.Sizes.medium)
                .padding(.bottom, Constants.Sizes.medium)
        }
        .radialGradientBackground(endRadius: 200)
    }
}
