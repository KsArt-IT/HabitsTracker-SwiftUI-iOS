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
    
    /// Возвращает начало дня (00:00:00) для текущей даты
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// Возвращает конец дня (23:59:59.999...) для текущей даты
    var endOfDay: Date {
        let calendar = Calendar.current
        let startOfNextDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        return calendar.date(byAdding: .second, value: -1, to: startOfNextDay)!
    }
}
