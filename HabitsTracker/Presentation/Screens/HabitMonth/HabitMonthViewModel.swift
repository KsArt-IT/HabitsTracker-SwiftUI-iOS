//
//  HabitMonthViewModel.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import Foundation
import Combine

final class HabitMonthViewModel: ObservableObject {
    private let repository: HabitRepository
    
    @Published var habitStatus: [HabitMonthStatus] = []
    private var dateRange: MonthRange
    private var date: Date = Date.now {
        didSet {
            dateRange = date.toMonthRange()
        }
    }
    
    private var task: Task<(), Never>?
    private var cancellables: Set<AnyCancellable> = []

    init(repository: HabitRepository) {
        self.repository = repository
        // для инициализации
        dateRange = date.toMonthRange()
        
        // загрузим данные
        fetchData()
        // наблюдаем за добавлением и изменением записей
        self.subscribeReload()
    }
    
    // MARK: - Fetch Habits
    func fetchData() {
        print("HabitMonthViewModel: \(#function)")
        guard task == nil else { return }
        date = Date.now
        let newTask = Task { [weak self] in
            await self?.fetchHabits()
            
            self?.task = nil
        }
        self.task = newTask
    }
    
    private func fetchHabits() async {
        print("HabitMonthViewModel: \(#function) user=\(Profile.user?.id.uuidString ?? "")")
        guard let user = Profile.user else { return }
        let result = await repository.fetchHabits(by: user.id, from: dateRange.start, to: dateRange.end)
        switch result {
        case .success(let habits):
            await filterAndSort(habits)
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    // MARK: - Update Habit
    private func reloadHabit(_ id: UUID) {
        Task { [weak self] in
            await self?.fetchHabit(id)
        }
    }
    
    private func fetchHabit(_ id: UUID) async {
        print("HabitMonthViewModel: \(#function) habit=\(id)")
        let result = await repository.fetchHabit(by: id, from: dateRange.start, to: dateRange.end)
        switch result {
        case .success(nil):
            // удалим из списка
            await setList(habitStatus.filter { $0.id != id })
        case .success(let habit):
            await updateList(habit!)
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
        let result = await repository.deleteHabit(by: id)
        switch result {
        case .success(_):
            await setList(habitStatus.filter { $0.id != id })
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    // MARK: - Show Message
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitMonthViewModel: message = \(message)")
    }
    
    // MARK: - Update List
    private func filterAndSort(_ habits: [Habit]) async {
        let start = dateRange.start
        let end = dateRange.end
        
        let list = habits.map {
            $0.toMonthStatus(current: date, start: start, end: end)
        }
        
        await sortList(list)
    }
    
    private func updateList(_ newItem: Habit) async {
        var newList = habitStatus.filter { $0.id != newItem.id }
        newList.append(
            newItem.toMonthStatus(current: date, start: dateRange.start, end: dateRange.end)
        )
        await sortList(newList)
    }
    
    private func sortList(_ newList: [HabitMonthStatus]) async {
        await self.setList(newList.sorted(by: <))
    }
    
    @MainActor
    private func setList(_ list: [HabitMonthStatus]) async {
        print("HabitMonthViewModel: \(#function) count = \(list.count)")
        guard habitStatus != list else { return }
        
        habitStatus = list
    }
    
    // MARK: - Subscribe
    private func subscribeReload() {
        repository.needReloadHabitPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(receiveValue: reloadHabit)
            .store(in: &cancellables)
    }
}
