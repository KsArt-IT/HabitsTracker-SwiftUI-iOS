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
    
    @Published private(set) var isLoading = false
    @Published var habitStatus: [HabitMonthStatus] = []
    @Published private(set) var date: Date = Date.now
    private var dateRange: MonthRange = Date.now.toMonthRange()
    
    private var task: Task<(), Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: HabitRepository) {
        self.repository = repository
        // загрузим данные
        fetchData()
        // наблюдаем за добавлением и изменением записей
        subscribeReload()
    }
    
    // MARK: - Fetch Habits
    private func fetchData(from newDate: Date = Date.now) {
        print("HabitMonthViewModel: \(#function)")
        guard Profile.user != nil else { return }
        if task != nil {
            task?.cancel()
            task = nil
        }
        let newTask = Task { [weak self] in
            await self?.setLoading()
            await self?.fetchHabits(from: newDate)
            await self?.setLoading(false)
            
            self?.task = nil
        }
        self.task = newTask
    }
    
    func fetchHabits(from newDate: Date = Date.now) async {
        print("HabitMonthViewModel: \(#function) user=\(Profile.user?.id.uuidString ?? "")")
        guard let user = Profile.user else { return }
        dateRange = newDate.toMonthRange()
        let result = await repository.fetchHabits(
            by: user.id,
            from: dateRange.start,
            to: dateRange.end,
        )
        switch result {
        case .success(let habits):
            await filterAndSort(habits)
            await setDate(newDate)
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
    
    // MARK: - Update List
    private func filterAndSort(_ habits: [Habit]) async {
        let current = Date.now
        let list = habits.map {
            $0.toMonthStatus(current: current, start: dateRange.start, end: dateRange.end)
        }
        
        await sortList(list)
    }
    
    private func updateList(_ newItem: Habit) async {
        var newList = habitStatus.filter { $0.id != newItem.id }
        newList.append(
            newItem.toMonthStatus(current: Date.now, start: dateRange.start, end: dateRange.end)
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
    
    // MARK: - Date change
    func previous() {
        fetchData(from: date.previousMonth())
    }
    
    func next() {
        fetchData(from: date.nextMonth())
    }
    
    @MainActor
    private func setDate(_ newDate: Date) {
        date = newDate
    }
    
    @MainActor
    private func setLoading(_ show: Bool = true) {
        isLoading = show
    }
    
    // MARK: - Show Message
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitMonthViewModel: message = \(message)")
    }
    
    // MARK: - Subscribe
    private func subscribeReload() {
        repository.needReloadHabitPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(receiveValue: reloadHabit)
            .store(in: &cancellables)
    }
}
