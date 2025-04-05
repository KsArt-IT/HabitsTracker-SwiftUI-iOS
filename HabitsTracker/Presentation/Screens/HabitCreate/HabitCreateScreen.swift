//
//  HabitCreateScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct HabitCreateScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: HabitCreateViewModel
    
    var body: some View {
        VStack {
            // Navigation back
            NavTitleView {
                dismiss()
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    CardNameEditView(text: $viewModel.cardTitle)
                    // How Often
                    PeriodEditView(selected: $viewModel.periodDays) {
                        // Your own schedule
                        ChooseWeekDaysView(check: viewModel.checkDay, change: viewModel.changeDay)
                    }
                    // Choose a time
                    ChooseTimeView(
                        times: $viewModel.times,
                        actionPositive: viewModel.timesAdd,
                        actionNegative: viewModel.timesDel
                    )
                    // Reminder
                    ReminderToggleView(enabled: $viewModel.reminderTimes)

                    PrimaryButton(label: "Create", disabled: viewModel.cardTitle.isEmpty) {
                        if viewModel.cardCreate() { dismiss() }
                    }
                }
            }
            
        }
        .padding(.horizontal, Constants.Sizes.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //    HabitCreateScreen()
}

