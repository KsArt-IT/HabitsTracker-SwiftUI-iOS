//
//  Habit.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

struct Habit: Identifiable {
    let id: String
    let title: String
    let createdAt: Date
    
    let userId: String
}
