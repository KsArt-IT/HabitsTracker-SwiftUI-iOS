//
//  HabitEditScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct HabitEditScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var viewModel: HabitEditViewModel
    @StateObject var notifications: LocalNotificationManager
    let id: UUID?
    
    var body: some View {
        VStack(spacing: Constants.Sizes.medium) {
            // Navigation back
            NavTitleView {
                dismiss()
            }
            
            if viewModel.edit {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Constants.Sizes.medium) {
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
                        ReminderToggleView(
                            reminder: $viewModel.reminderTimes,
                            granted: notifications.isGranted,
                            label: notifications.isPermission ? "Request Permission" : "Open Notification setings",
                        ) {
                            notifications.requestPermission()
                        }
                        
                        PrimaryButton(
                            label: id == nil ? "Create" : "Save",
                            disabled: viewModel.cardTitle.isEmpty
                        ) {
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
        .padding(.bottom, 1)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                notifications.checkGranted()
            }
        }
        .onChange(of: viewModel.closed) { _, newValue in
            if newValue { dismiss() }
        }
    }
}

#Preview {
    //    HabitCreateScreen()
}

