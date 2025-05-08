//
//  HourInterval.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation

struct HourInterval: Equatable, Hashable, Identifiable {
    let id: UUID
    let time: Int

    func copyWith(time: Int) -> Self {
        HourInterval(
            id: self.id,
            time: time,
        )
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.time < rhs.time
    }
}
