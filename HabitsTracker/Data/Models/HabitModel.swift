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
    var id: UUID = UUID()
    var userId: UUID

    var title: String
    var details: String = ""
    
    var createdAt: Date = Date.now
    var updateAt: Date = Date.now
    var completedAt: Date = Date.distantFuture
    
    var weekDaysRaw: Int = WeekDays.allDays // Хранит побитовые значения
    
    @Relationship(deleteRule: .cascade)
    var intervals: [HourIntervalModel] = []
    
    @Transient
    var completed: [HourIntervalCompletedModel] = []
    
    init(
        title: String,
        userId: UUID
    ) {
        self.title = title
        self.userId = userId
    }
    
    init(
        title: String,
        details: String = "",
        weekDaysRaw: Int = WeekDays.allDays,
        intervals: [HourIntervalModel],
        userId: UUID
    ) {
        self.title = title
        self.details = details
        
        self.weekDaysRaw = weekDaysRaw
        self.intervals = intervals
        
        self.userId = userId
    }
    
    init(
        id: UUID,
        title: String,
        details: String,

        createdAt: Date,
        updateAt: Date,
        completedAt: Date,
        
        weekDaysRaw: Int,
        intervals: [HourIntervalModel] = [],
        completed: [HourIntervalCompletedModel] = [],

        userId: UUID
    ) {
        self.id = id
        self.title = title
        self.details = details
        
        self.createdAt = createdAt
        self.updateAt = updateAt
        self.completedAt = completedAt
        
        self.weekDaysRaw = weekDaysRaw
        self.intervals = intervals
        self.completed = completed
        
        self.userId = userId
    }
}
