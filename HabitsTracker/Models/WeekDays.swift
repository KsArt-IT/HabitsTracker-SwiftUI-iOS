//
//  WeekDays.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import SwiftUICore

enum WeekDays: LocalizedStringResource, CaseIterable, Identifiable, Hashable {
    case monday    = "Monday"
    case friday    = "Friday"
    case tuesday   = "Tuesday"
    case saturday  = "Saturday"
    case wednesday = "Wednesday"
    case sunday    = "Sunday"
    case thursday  = "Thursday"
}

extension WeekDays {
    var id: Self { self }
    
    var bit: Int {
        switch self {
        case .monday: 1
        case .tuesday: 2
        case .wednesday: 4
        case .thursday: 8
        case .friday: 16
        case .saturday: 32
        case .sunday: 64
        }
    }
    
    static let allDays: Int = 127
}

extension Set where Element == WeekDays {
    var rawValue: Int {
        self.reduce(0) { $0 | $1.bit } // Побитовое ИЛИ
    }
    
    static func from(rawValue: Int) -> Set<WeekDays> {
        Set(WeekDays.allCases.filter { rawValue & $0.bit != 0 })
    }
}
