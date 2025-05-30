//
//  HourIntervalCompletedModel.swift
//  HabitsTracker
//
//  Created by KsArT on 14.04.2025.
//

import Foundation
import SwiftData

@Model
final class HourIntervalCompletedModel {
    @Attribute(.unique)
    var id: UUID
    var habitId: UUID
    var intervalId: UUID
    var time: Int
    var completedAt: Date
    
    init(
        id: UUID = UUID(),
        habitId: UUID,
        intervalId: UUID,
        time: Int,
        completedAt: Date = Date.now,
    ) {
        self.id = id
        self.habitId = habitId
        self.intervalId = intervalId
        self.time = time
        self.completedAt = completedAt
    }
}
