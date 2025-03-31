//
//  HourIntervalModel.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation
import SwiftData

@Model
final class HourIntervalModel {
    @Attribute(.unique)
    var id: UUID
    var time: Int // время в секундах
    
    @Relationship(deleteRule: .cascade)
    var habit: HabitModel
    
    init(id: UUID, time: Int, habit: HabitModel) {
        self.id = id
        self.time = time
        self.habit = habit
    }
}
