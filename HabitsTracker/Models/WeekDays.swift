//
//  WeekDays.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import SwiftUICore

enum WeekDays: LocalizedStringKey, CaseIterable, Identifiable {
    case monday    = "Monday"
    case tuesday   = "Tuesday"
    case wednesday = "Wednesday"
    case thursday  = "Thursday"
    case friday    = "Friday"
    case saturday  = "Saturday"
    case sunday    = "Sunday"
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
