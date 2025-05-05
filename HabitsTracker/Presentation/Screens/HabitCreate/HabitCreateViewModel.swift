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
    @Published var closed: Bool = false
    
    private var task: Task<(), Never>?
    
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
    
    public func cardCreate() {
        guard task == nil else { return }
        let newTask = Task { [weak self] in
            await self?.createHabit()
            
            self?.task = nil
        }
        self.task = newTask
    }
    
    private func createHabit() async {
        print("HabitCreateViewModel: \(#function)")
        guard let user = Profile.user else {
            await showMessage("User = nil")
            print("HabitCreateViewModel::loadHabits: User = nil")
            await self.close()
            return
        }
        
        let habit = Habit(
            id: UUID(),
            userId: user.id,
            title: cardTitle,
            details: "",
            createdAt: Date.now,
            updateAt: Date.now,
            completedAt: Date.distantFuture,
            weekDays: days.isEmpty ? Set<WeekDays>(WeekDays.allCases): days,
            intervals: times.map { HourInterval(id: UUID(), time: $0) },
            completed: []
        )
        
        let result  = await repository.saveHabit(habit)
        switch result {
        case .success(_):
            await self.close()
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitCreateViewModel: message = \(message)")
    }
    
    @MainActor
    private func close() {
        print("HabitCreateViewModel: \(#function)")
        closed = true
    }
}
