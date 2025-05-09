//
//  HabitDayScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitDayScreen: View {
    @MainActor
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @StateObject var viewModel: HabitDayViewModel
    @Binding var habitMenu: HabitMenu
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.habits.isEmpty {
                TextNoItem()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: Constants.Sizes.spacingHabit) {
                        ForEach(viewModel.habits) { habit in
                            HabitItemView(habit: habit) {
                                habitMenu = .action(id: habit.id)
                            } edit: {
                                habitMenu = .edit(id: habit.id)
                            } delete: {
                                viewModel.deleteHabit(by: habit.id)
                            }
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchHabits()
                }
            }
        }
        .padding(.top, Constants.Sizes.medium)
    }
}

#Preview {
//    HabitDayScreen()
}
