//
//  HabitCreateScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct HabitEditScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: HabitEditViewModel
    let id: UUID?
    
    var body: some View {
        VStack {
            // Navigation back
            NavTitleView {
                dismiss()
            }
            
            if viewModel.edit {
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
                            times: viewModel.times,
                            change: viewModel.changeTime,
                            actionPositive: viewModel.timesAdd,
                            actionNegative: viewModel.timesDel
                        )
                        // Reminder
                        ReminderToggleView(enabled: $viewModel.reminderTimes)
                        
                        PrimaryButton(label: "Create", disabled: viewModel.cardTitle.isEmpty) {
                            viewModel.saveHabit()
                        }
                    }
                }
            } else {
                ZStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .task {
                    await viewModel.fetchHabit(by: id)
                }
            }
            
        }
        .padding(.horizontal, Constants.Sizes.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: viewModel.closed) { _, newValue in
            if newValue { dismiss() }
        }
    }
}

#Preview {
    //    HabitCreateScreen()
}

