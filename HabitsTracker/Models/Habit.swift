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
    static func < (lhs: Self, rhs: Self) -> Bool {
        (lhs.title, lhs.details) < (rhs.title, rhs.details)
    }
    
    // MARK: - Copy
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

extension Habit {
    func toWeekStatus(
        current: Date,
        start: Date,
        end: Date,
    ) -> HabitWeekStatus {
        HabitWeekStatus(
            id: self.id,
            title: self.title,
            habitStatus: Habit.calculateWeekStatus(
                self,
                currentDate: current.endOfDay,
                start: start,
                numberOfDays: CalendarExt.calendar.dateComponents([.day], from: start, to: end).day ?? 0
            )
        )
    }
    
    static private func calculateWeekStatus(
        _ habit: Habit,
        currentDate: Date,
        start: Date,
        numberOfDays: Int
    ) -> [HabitDayStatus] {
        (0...numberOfDays).map { offset in
            let day = CalendarExt.calendar.date(byAdding: .day, value: offset, to: start)!
            return getStatus(habit: habit, day: day, currentDate: currentDate)
        }
    }
    
    static private func getStatus(
        habit: Habit,
        day: Date,
        currentDate: Date,
    ) -> HabitDayStatus {
        if day > habit.completedAt {
            return .closed
        }
        
        if day < habit.createdAt {
            return .notStarted
        }
        
        if !habit.weekDays.contains(WeekDays.from(date: day)) {
            return .skipped
        }
        
        if day > currentDate {
            return .awaitsExecution
        }
        
        let completedCount = habit.completed.filter { $0.completedAt.inSameDay(day) }.count
        
        return switch completedCount {
        case habit.intervals.count:
                .completed
        case 1...:
                .partiallyCompleted
        default:
                .notCompleted
        }
    }
}
