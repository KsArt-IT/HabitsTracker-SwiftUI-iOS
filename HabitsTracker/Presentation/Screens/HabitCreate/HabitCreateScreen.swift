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
        ScrollView {
            VStack {
                // Navigation back
                NavTitleView {
                    dismiss()
                }
                CardNameEditView(text: $viewModel.cardTitle)
                // How Often
                PeriodEditView(selected: $viewModel.periodDays) {
                    // Your own schedule
                    ChooseWeekDaysView(check: viewModel.checkDay, change: viewModel.changeDay)
                }
            }
        }
        .padding(.horizontal, Constants.Sizes.medium)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
//    HabitCreateScreen()
}

