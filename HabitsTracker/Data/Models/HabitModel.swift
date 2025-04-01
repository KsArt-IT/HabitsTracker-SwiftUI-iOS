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
    
    var title: String
    var descript: String = ""
    
    var createdAt: Date = Date.now
    var lastCompletedDate: Date = Date.distantFuture
    
    var weekDaysRaw: Int = WeekDays.allDays // Хранит побитовые значения
    
    @Relationship(deleteRule: .cascade)
    var intervals: [HourIntervalModel] = []
    
    @Relationship(deleteRule: .cascade)
    var user: UserModel
    
    init(
        title: String,
        user: UserModel
    ) {
        self.title = title
        self.user = user
    }
    
    init(
        title: String,
        descript: String = "",
        weekDaysRaw: Int = WeekDays.allDays,
        intervals: [HourIntervalModel],
        user: UserModel
    ) {
        self.title = title
        self.descript = descript
        
        self.weekDaysRaw = weekDaysRaw
        self.intervals = intervals
        
        self.user = user
    }
    
    init(
        id: UUID,
        title: String,
        descript: String,
        createdAt: Date,
        lastCompletedDate: Date,
        weekDaysRaw: Int,
        intervals: [HourIntervalModel] = [],
        user: UserModel
    ) {
        self.id = id
        self.title = title
        self.descript = descript
        
        self.createdAt = createdAt
        self.lastCompletedDate = lastCompletedDate
        
        self.weekDaysRaw = weekDaysRaw
        self.intervals = intervals
        
        self.user = user
    }
}
