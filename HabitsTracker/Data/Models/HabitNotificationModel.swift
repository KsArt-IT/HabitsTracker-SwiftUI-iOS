//
//  HabitNotificationModel.swift
//  HabitsTracker
//
//  Created by KsArT on 10.05.2025.
//

import Foundation
import SwiftData

@Model
final class HabitNotificationModel {
    @Attribute(.unique)
    var id: UUID
    var identifier: String
    
    var weekDay: Int // день недели или все дни
    var time: Int // время в минутах от 0:00
    var repeats: Bool // повтор каждый день, иначе создается массив для каждого следующего дня
    
    var habitId: UUID
    var intervalId: UUID
    
    var habit: HabitModel?

    init(
        id: UUID,
        identifier: String,

        weekDay: Int,
        time: Int,
        repeats: Bool,
        
        habitId: UUID,
        intervalId: UUID
    ) {
        self.id = id
        self.identifier = identifier
        self.weekDay = weekDay
        self.time = time
        self.repeats = repeats
        self.habitId = habitId
        self.intervalId = intervalId
    }
}
