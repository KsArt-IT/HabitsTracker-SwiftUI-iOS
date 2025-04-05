//
//  DateExt.swift
//  HabitsTracker
//
//  Created by KsArT on 05.04.2025.
//

import Foundation

extension Date {
    func toMinutesFromDate() -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return hour * 60 + minute
    }
}
