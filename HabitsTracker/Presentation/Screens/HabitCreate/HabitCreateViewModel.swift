//
//  HabitCreateViewModel.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import Foundation

final class HabitCreateViewModel: ObservableObject {
    private let repository: HabitRepository
    
    @Published var cardTitle: String = ""

    @Published var periodDays: Int = 0
    private var days: Set<WeekDays> = []

    private let startTime: Int = 0 //12:00 am - minutes
    @Published var times: [Int]

    @Published var reminderTimes: Bool = false

    init(repository: HabitRepository) {
        self.repository = repository
        times = [startTime]
    }
    
    public func checkDay(day: WeekDays) -> Bool {
        days.contains(day)
    }
    
    public func changeDay(day: WeekDays, checked: Bool) {
        if checked {
            days.insert(day)
        } else {
            days.remove(day)
        }
    }
    
    public func timesAdd() {
        times.append(startTime)
    }
    
    public func timesDel() {
        times.removeLast()
    }
    
    public func cardCreate() -> Bool {
        true
    }
}
