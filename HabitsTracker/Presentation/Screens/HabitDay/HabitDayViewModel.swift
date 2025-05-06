//
//  HabitFlowViewModel.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import Foundation
import Combine

final class HabitDayViewModel: ObservableObject {
    private let habitRepository: HabitRepository
    @Published var habits: [Habit] = []
    
    private var task: Task<(), Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: HabitRepository) {
        self.habitRepository = repository
        
        // наблюдаем за добавлением и изменением записей
        self.subscribeUpdate()
    }
    
    func fetchHabits() {
        print("HabitDayViewModel: \(#function)")
        guard task == nil else { return }
        let newTask = Task { [weak self] in
            await self?.fetchHabits()
            
            self?.task = nil
        }
        self.task = newTask
    }
    
    private func fetchHabits() async {
        print("HabitDayViewModel: \(#function) user=\(Profile.user?.id.uuidString ?? "")")
        guard let user = Profile.user else { return }
        
        let result = await habitRepository.fetchHabits(by: user.id, from: Date.now)
        switch result {
        case .success(let habits):
            sortList(habits)
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    // MARK: - Delete
    func deleteHabit(by id: UUID) {
        Task { [weak self] in
            await self?.deleteHabit(id: id)
        }
    }
    
    private func deleteHabit(id: UUID) async {
        let result = await habitRepository.deleteHabit(by: id)
        switch result {
        case .success(_):
            await setList(habits.filter { $0.id != id })
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    // MARK: - Show Message
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitDayViewModel: message = \(message)")
    }
    
    // MARK: - Update List
    private func updateList(_ newItem: Habit) {
        var newList = habits.filter { $0.id != newItem.id }
        newList.append(newItem)
        sortList(newList)
    }
    
    private func sortList(_ newList: [Habit]) {
        Task { [weak self] in
            await self?.setList(newList.sorted(by: <))
        }
    }
    
    @MainActor
    private func setList(_ list: [Habit]) {
        print("HabitDayViewModel: \(#function) count = \(list.count)")
        guard habits != list else { return }
        
        habits = list
    }
    
    // MARK: - Subscribe
    private func subscribeUpdate() {
        habitRepository.updatePublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(receiveValue: updateList)
            .store(in: &cancellables)
    }
    
}
