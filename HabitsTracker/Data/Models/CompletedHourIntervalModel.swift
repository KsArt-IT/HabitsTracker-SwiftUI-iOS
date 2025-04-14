//
//  HourIntervalModel.swift
//  HabitsTracker
//
//  Created by KsArT on 14.04.2025.
//

import Foundation
import SwiftData

@Model
final class CompletedHourIntervalModel {
    @Attribute(.unique)
    var id: UUID
    var time: Int // время в секундах
    var completed: Date
    
    @Relationship(deleteRule: .cascade)
    var habit: HabitModel
    
    init(id: UUID, time: Int, habit: HabitModel, completed: Date) {
        self.id = id
        self.time = time
        self.habit = habit
        self.completed = completed
    }
}
