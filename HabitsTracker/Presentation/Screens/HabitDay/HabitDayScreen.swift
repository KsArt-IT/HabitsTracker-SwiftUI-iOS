//
//  HabitDayScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitDayScreen: View {
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @StateObject var viewModel: HabitDayViewModel

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.habits.isEmpty {
                Text("No habits")
                    .font(Constants.Fonts.normalRegular)
                    .foregroundStyle(Color.textGray)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: Constants.Sizes.spacingHabit) {
                        ForEach(viewModel.habits) { habit in
                            HabitItemView(habit: habit) {
                                
                            } edit: {
                                
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, Constants.Sizes.medium)
        .onAppear {
            viewModel.fetchHabits()
        }
    }
}

#Preview {
//    HabitDayScreen()
}
