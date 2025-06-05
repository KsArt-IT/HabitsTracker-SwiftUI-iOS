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
            DaySelectorView(date: $viewModel.date)
            if viewModel.habits.isEmpty || viewModel.isLoading {
                ZStack {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        TextNoItem()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
    }
}

#Preview {
    //    HabitDayScreen()
}
