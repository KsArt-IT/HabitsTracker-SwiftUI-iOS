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
    
    var notifiAt: Date // дата срабатывания
    var repeats: Bool // повтор каждый день, иначе создается массив для каждого следующего дня
    
    var habitId: UUID
    var intervalId: UUID
    
    var habit: HabitModel?

    init(
        id: UUID,
        identifier: String,

        notifiAt: Date,
        repeats: Bool,
        
        habitId: UUID,
        intervalId: UUID
    ) {
        self.id = id
        self.identifier = identifier
        self.notifiAt = notifiAt
        self.repeats = repeats
        self.habitId = habitId
        self.intervalId = intervalId
    }
}
