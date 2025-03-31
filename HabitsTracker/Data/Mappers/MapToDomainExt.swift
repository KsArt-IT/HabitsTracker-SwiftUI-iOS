//
//  MapToDomainExt.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation

extension UserModel {
    func toDomain() -> User {
        return User(
            id: id,
            name: name
        )
    }
}

extension HabitModel {
    func toDomain() -> Habit {
        return Habit(
            id: id,
            userId: user.id,
            
            title: title,
            description: descript,
            
            createdAt: createdAt,
            lastCompletedDate: lastCompletedDate,
            weekDays: Set<WeekDays>.from(rawValue: weekDaysRaw),
            intervals: intervals.map { $0.toDomain() }
        )
    }
}

extension HourIntervalModel {
    func toDomain() -> HourInterval {
        return HourInterval(
            id: id,
            time: time
        )
    }
}
