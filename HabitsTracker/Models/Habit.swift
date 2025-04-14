//
//  Habit.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

struct Habit: Identifiable, Equatable, Comparable, Hashable {
    let id: UUID
    let userId: UUID

    let title: String
    let details: String

    let createdAt: Date
    let lastCompletedDate: Date

    let weekDays: Set<WeekDays>
    let intervals: [HourInterval]
    let completed: [CompletedHourInterval]

    // MARK: - Comparable
    static func < (lhs: Habit, rhs: Habit) -> Bool {
        (lhs.title, lhs.details) < (rhs.title, rhs.details)
    }
}
