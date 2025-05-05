//
//  CompletedHourIntervalModel.swift
//  HabitsTracker
//
//  Created by KsArT on 14.04.2025.
//

import Foundation

struct HourIntervalCompleted: Equatable, Hashable {
    let id: UUID
    let intervalId: UUID
    let time: Int // время в секундах
    let completedAt: Date
}
