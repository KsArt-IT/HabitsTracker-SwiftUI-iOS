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
}

extension HourInterval {
    func copyWith(time: Int) -> HourInterval {
        HourInterval(
            id: self.id,
            time: time,
        )
    }
    
    static func < (lhs: HourInterval, rhs: HourInterval) -> Bool {
        lhs.time < rhs.time
    }
}
