//
//  HabitItemView.swift
//  HabitsTracker
//
//  Created by KsArT on 14.04.2025.
//

import SwiftUI

struct HabitItemView: View {
    let habit: Habit
    let action: () -> Void
    let edit: () -> Void
    let delete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            TitleTextAndMenuView(title: habit.title, edit:edit, delete: delete)
            
            Spacer()
            
            HStack(spacing: 0) {
                Text("\(habit.completed.count)/\(habit.intervals.count)")
                    .font(Constants.Fonts.accentMedium)
                    .foregroundStyle(Color.brandText)
                Spacer(minLength: Constants.Sizes.small)
                Button(action: action) {
                    Image("ArrowUpRight")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.Sizes.icon, height: Constants.Sizes.icon)
                        .padding(Constants.Sizes.habitIconPadding)
                }
                .foregroundStyle(Color.brand)
                .background(Color.brandBlack)
                .clipShape(.circle)
            }
        }
        .padding(.leading, Constants.Sizes.habitPaddingLeading)
        .padding(.vertical, Constants.Sizes.habitPadding)
        .padding(.trailing, Constants.Sizes.habitPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.Sizes.habitCornerRadius)
                .fill(
                    RadialGradient(
                        colors: [.formBackground, .formBackground.opacity(0.4)],
                        center: .topTrailing,
                        startRadius: .zero,
                        endRadius: 150
                    )
                )
        )
    }
}

#Preview {
    let userId = UUID()
    
    HStack(spacing: 0) {
        HabitItemView(
            habit: Habit(
                id: UUID(),
                userId: userId,
                title: "Here is a very long habit name for display testing",
                details: "",
                createdAt: Date.now,
                updateAt: Date.now,
                completedAt: Date.distantFuture,
                weekDays: [WeekDays.monday, WeekDays.tuesday],
                intervals: [
                    HourInterval(id: UUID(), time: 180)
                ],
                completed: [
                    HourIntervalCompleted(
                        id: UUID(),
                        intervalId: UUID(),
                        time: 180,
                        completedAt: Date.now
                    )
                ]
            ),
            action: {},
            edit: {},
            delete: {},
        )
        Spacer(minLength: 16)
        HabitItemView(
            habit: Habit(
                id: UUID(),
                userId: userId,
                title: "Title Habit",
                details: "",
                createdAt: Date.now,
                updateAt: Date.now,
                completedAt: Date.distantFuture,
                weekDays: [WeekDays.monday, WeekDays.tuesday],
                intervals: [
                    HourInterval(id: UUID(), time: 180),
                    HourInterval(id: UUID(), time: 200)
                ],
                completed: [
                    HourIntervalCompleted(
                        id: UUID(),
                        intervalId: UUID(),
                        time: 180,
                        completedAt: Date.now
                    )
                ]
            ),
            action: {},
            edit: {},
            delete: {},
        )
    }
    .padding()
}
