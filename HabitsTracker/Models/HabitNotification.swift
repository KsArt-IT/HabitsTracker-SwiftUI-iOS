//
//  HabitNotification.swift
//  HabitsTracker
//
//  Created by KsArT on 10.05.2025.
//

import Foundation

struct HabitNotification: Equatable, Hashable, Identifiable {
    let id: UUID
    let identifier: String
    
    let weekDay: Int
    let time: Int
    let repeats: Bool
    
    let intervalId: UUID
}
