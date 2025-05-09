//
//  MapToModelExt.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation

extension User {
    func toModel() -> UserModel {
        UserModel(
            id: self.id,
            name: self.name,
            createdAt: self.createdAt,
        )
    }
}

extension Habit {
    func toModel() -> HabitModel {
        HabitModel(
            id: id,
            userId: userId,
            
            title: title,
            details: details,
            
            createdAt: createdAt,
            completedAt: completedAt,
            
            weekDaysRaw: weekDays.rawValue,
            intervals: intervals.map { $0.toModel() },
        )
    }
}

extension HourInterval {
    func toModel() -> HourIntervalModel {
        HourIntervalModel(
            id: id,
            time: time,
        )
    }
}

extension HourIntervalCompleted {
    func toModel(habitId: UUID) -> HourIntervalCompletedModel {
        HourIntervalCompletedModel(
            id: id,
            habitId: habitId,
            intervalId: intervalId,
            time: time,
            completedAt: completedAt,
        )
    }
}
