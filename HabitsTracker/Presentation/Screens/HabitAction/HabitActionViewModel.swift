//
//  HabitActionViewModel.swift
//  HabitsTracker
//
//  Created by KsArT on 06.05.2025.
//

import Foundation

final class HabitActionViewModel: ObservableObject {
    private let repository: HabitRepository
    
    @Published var habit: Habit?
    private var isNeedReload = false
    
    init(repository: HabitRepository) {
        self.repository = repository
    }
    
    func fetchHabit(by id: UUID) async {
        let result = await repository.fetchHabit(by: id)
        switch result {
        case .success(let habit):
            await self.setHabit(habit)
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
        
    }
    
    func deleteHabit() {
        Task { [weak self] in
            guard let id = self?.habit?.id else { return }
            let result = await self?.repository.deleteHabit(by: id)
            if case .failure(let error) = result {
                await self?.showMessage(error.localizedDescription)
            }
        }
    }
    
    func reloadHabit() {
        guard let habit, isNeedReload == true else { return }
        Task { [weak self] in
            self?.repository.reloadHabit(by: habit.id)
        }
    }
    
    func check(_ id: UUID) -> Bool {
        habit?.completed.first { $0.intervalId == id } != nil
    }
    
    func change(_ interval: HourInterval) {
        Task {[weak self] in
            await self?.changeCompleted(interval)
        }
    }
    
    private func changeCompleted(_ interval: HourInterval) async {
        guard let habit else { return }
        
        var completeds = habit.completed
        if let completed = habit.completed.first(where: { $0.intervalId == interval.id }) {
            let result = await repository.deleteCompleted(by: completed.id)
            if case .failure(let error) = result {
                await showMessage(error.localizedDescription)
                return
            } else {
                completeds.removeAll { $0.id == completed.id }
            }
        } else {
            let completed = HourIntervalCompleted(
                id: UUID(),
                intervalId: interval.id,
                time: interval.time,
                completedAt: Date.now
            )
            let result = await repository.saveCompleted(by: habit.id, completed: completed)
            if case .failure(let error) = result {
                await showMessage(error.localizedDescription)
                return
            } else {
                completeds.append(completed)
            }
        }
        isNeedReload = true
        await setHabit(habit.copyWith(completed: completeds))
    }
    
    @MainActor
    private func setHabit(_ habit: Habit) {
        self.habit = habit
    }
    
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitActionViewModel: message = \(message)")
    }
    
}
