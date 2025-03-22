//
//  HabitFlowViewModel.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import Foundation

final class HabitDayViewModel: ObservableObject {
    private let habitRepository: HabitRepository
    @Published var habits: [Habit] = []
    
    private var task: Task<(), Never>?

    init(repository: HabitRepository) {
        self.habitRepository = repository
    }
    
    func loadHabits(name: String) {
        guard task == nil else { return }
        let newTask = Task {
            await loadHabits()
        }
    }
    
    private func loadHabits() async {
        let result = await habitRepository.fetchHabits()
    }
    
    func addHabit() {
        // Будет реализовано позже
    }
    
    @MainActor
    private func setHabits() {
        
    }

}
