//
//  IntExt.swift
//  HabitsTracker
//
//  Created by KsArT on 05.04.2025.
//

import Foundation

extension Int {
    func toHoursMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        var hourIn12 = hours % 12
        hourIn12 = hourIn12 == 0 ? 12 : hourIn12 // 0 часов — это 12 AM или 12 PM
        
        return String(format: "%02d:%02d", hourIn12, minutes)
    }
    
    func toHoursAmPm() -> String {
        self / 60 < 12 ? "am" : "pm"
    }
    
    func toggleAmPm() -> Int {
        self < 720 ? self + 720 : self - 720
    }
    
    func toDateFromMinutes() -> Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return calendar.date(byAdding: .minute, value: self, to: today) ?? today
    }
}
