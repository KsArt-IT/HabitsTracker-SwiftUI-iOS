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
    let updatedAt: Date
    let completedAt: Date
    
    let weekDays: Set<WeekDays>
    let intervals: [HourInterval]
    let completed: [HourIntervalCompleted]

    var isActive: Bool { completedAt == Date.distantFuture }
    
    // MARK: - Comparable
    static func < (lhs: Habit, rhs: Habit) -> Bool {
        (lhs.title, lhs.details) < (rhs.title, rhs.details)
    }
    
    func copyWith(
        title: String? = nil,
        details: String? = nil,
        completedAt: Date? = nil,
        weekDays: Set<WeekDays>? = nil,
        intervals: [HourInterval]? = nil,
        completed: [HourIntervalCompleted]? = nil,
    ) -> Habit {
        Habit(
            id: id,
            userId: userId,
            title: title ?? self.title,
            details: details ?? self.details,
            createdAt: createdAt,
            updatedAt: Date.now,
            completedAt: completedAt ?? self.completedAt,
            weekDays: weekDays ?? self.weekDays,
            intervals: intervals ?? self.intervals,
            completed: completed ?? self.completed,
        )
    }
}
