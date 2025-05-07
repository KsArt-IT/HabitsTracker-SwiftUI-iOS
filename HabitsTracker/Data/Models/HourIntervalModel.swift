//
//  HourIntervalModel.swift
//  HabitsTracker
//
//  Created by KsArT on 31.03.2025.
//

import Foundation
import SwiftData

@Model
final class HourIntervalModel {
    @Attribute(.unique)
    var id: UUID
    
    var time: Int // время в секундах

    var habit: HabitModel?

    init(id: UUID = UUID(), time: Int) {
        self.id = id
        self.time = time
    }
}
