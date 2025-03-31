//
//  Habit.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

struct Habit: Identifiable {
    let id: UUID
    let userId: UUID?

    let title: String
    let description: String
    
    let createdAt: Date
    let lastCompletedDate: Date
    
    let weekDays: Set<WeekDays>
    let intervals: [HourInterval]
}
