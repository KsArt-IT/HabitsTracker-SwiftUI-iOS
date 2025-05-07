//
//  HabitModel.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation
import SwiftData

@Model
final class HabitModel {
    @Attribute(.unique)
    var id: UUID
    
    var userId: UUID
    var title: String
    var details: String = ""

    var createdAt: Date = Date.now
    var updatedAt: Date = Date.now
    var completedAt: Date = Date.distantFuture

    var weekDaysRaw: Int = WeekDays.allDays

    @Relationship(deleteRule: .cascade, inverse: \HourIntervalModel.habit)
    var intervals: [HourIntervalModel] = []

    @Transient
    var completed: [HourIntervalCompletedModel] = []

    init(
        id: UUID = UUID(),
        title: String,
        details: String = "",

        createdAt: Date,
        updatedAt: Date,
        completedAt: Date,
        
        weekDaysRaw: Int,
        intervals: [HourIntervalModel] = [],
        completed: [HourIntervalCompletedModel] = [],

        userId: UUID,
    ) {
        self.id = id
        self.title = title
        self.details = details
        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.completedAt = completedAt
        
        self.weekDaysRaw = weekDaysRaw
        self.intervals = intervals
        self.completed = completed
        
        self.userId = userId
    }
}
