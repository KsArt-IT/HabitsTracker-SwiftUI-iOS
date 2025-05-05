//
//  MapToDomainExt.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation

extension UserModel {
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            createdAt: createdAt,
        )
    }
}

extension HabitModel {
    func toDomain() -> Habit {
        Habit(
            id: id,
            userId: userId,
            
            title: title,
            details: details,
            
            createdAt: createdAt,
            updateAt: updateAt,
            completedAt: completedAt,
            
            weekDays: Set<WeekDays>.from(rawValue: weekDaysRaw),
            intervals: intervals.map { $0.toDomain() },
            completed: completed.map { $0.toDomain() }
        )
    }
}

extension HourIntervalModel {
    func toDomain() -> HourInterval {
        HourInterval(
            id: id,
            time: time
        )
    }
}

extension HourIntervalCompletedModel {
    func toDomain() -> HourIntervalCompleted {
        HourIntervalCompleted(
            id: id,
            intervalId: intervalId,
            time: time,
            completedAt: completedAt
        )
    }
}
