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
    
    @Relationship(deleteRule: .cascade)
    var intervals: [HourIntervalModel] = []
    
    @Relationship(deleteRule: .cascade)
    var notifications: [HabitNotificationModel] = []
    
    @Transient
    var completed: [HourIntervalCompletedModel] = []
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        
        title: String,
        details: String = "",
        
        createdAt: Date,
        updatedAt: Date = Date.now,
        completedAt: Date = Date.distantFuture,
        
        weekDaysRaw: Int = WeekDays.allDays,
        intervals: [HourIntervalModel] = [],
        notifications: [HabitNotificationModel] = [],
        
        completed: [HourIntervalCompletedModel] = [],
    ) {
        self.id = id
        self.userId = userId
        
        self.title = title
        self.details = details
        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.completedAt = completedAt
        
        self.weekDaysRaw = weekDaysRaw
        self.intervals = intervals
        
        self.notifications = notifications

        self.completed = completed
    }
}
