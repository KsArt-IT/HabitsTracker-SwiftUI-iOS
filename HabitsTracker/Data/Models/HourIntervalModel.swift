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
    var habitId: UUID
    var time: Int // время в секундах
    
    init(
        id: UUID,
        habitId: UUID,
        time: Int,
    ) {
        self.id = id
        self.habitId = habitId
        self.time = time
    }
}
