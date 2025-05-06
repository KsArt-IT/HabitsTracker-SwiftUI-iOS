//
//  HabitActionScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 06.05.2025.
//

import SwiftUI

struct HabitActionScreen: View {
    @MainActor
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: HabitActionViewModel
    let id: UUID
    @Binding var habitMenu: HabitMenu
    
    var body: some View {
        VStack {
            // Navigation back
            NavTitleView {
                dismiss()
            }
            
            if let habit = viewModel.habit {
                FormTitleAndMenuView(
                    habit.title,
                    edit: {
                        habitMenu = .edit(id: habit.id)
                    },
                    delete: {
                        viewModel.deleteHabit()
                        dismiss()
                    }) {
                        LazyVGrid(columns: columns, spacing: Constants.Sizes.spacingHabit) {
                            ForEach(habit.intervals) { interval in
                                CheckBoxView(label: interval.time.toHoursMinutes(), checked: viewModel.check(interval.id)) { _ in
                                    viewModel.change(interval)
                                }
                            }
                        }
                        .padding(.horizontal, Constants.Sizes.medium)
                        .padding(.bottom, Constants.Sizes.medium)
                    }
                    .padding(.vertical, Constants.Sizes.small)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    //    HabitActionScreen()
}
