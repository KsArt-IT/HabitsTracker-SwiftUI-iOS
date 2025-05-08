//
//  HabitMonth.swift
//  HabitsTracker
//
//  Created by KsArT on 08.05.2025.
//

import Foundation

struct HabitMonthStatus {
    let id: UUID
    let title: String
    let habitStatus: [[HabitDayStatus]]
    
    // MARK: - Comparable
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.title < rhs.title
    }
}
