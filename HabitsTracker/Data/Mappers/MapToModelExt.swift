//
//  MapToModelExt.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation

extension User {
    func toModel() -> UserModel {
        UserModel(id: self.id, name: self.name)
    }
}

extension Habit {
    func toModel(user: User) -> HabitModel {
        let habit = HabitModel(
            id: id,
            title: title,
            descript: description,
            
            createdAt: createdAt,
            lastCompletedDate: lastCompletedDate,
            
            weekDaysRaw: self.weekDays.rawValue,
            
            user: user.toModel()
        )
        habit.intervals = intervals.map { $0.toModel(habit: habit) }
        return habit
    }
}

extension HourInterval {
    func toModel(habit: HabitModel) -> HourIntervalModel {
        HourIntervalModel(
            id: id,
            time: time,
            habit: habit
        )
    }
}
