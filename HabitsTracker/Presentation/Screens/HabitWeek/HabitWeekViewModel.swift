//
//  HabitWeekViewModel.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import Foundation
import Combine

final class HabitWeekViewModel: ObservableObject {
    private let repository: HabitRepository
    
    @Published private(set) var isLoading = false
    @Published var habitStatus: [HabitWeekStatus] = []
    private var isUpdateDate = false
    @Published var date: Date = Date.now {
        didSet {
            guard !isUpdateDate else { return }
            fetchData(from: date)
        }
    }
    private var dateRange: WeekRange = Date.now.toWeekRange()
    
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
        print("HabitWeekViewModel: \(#function)")
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
        print("HabitWeekViewModel: \(#function) user=\(Profile.user?.id.uuidString ?? "")")
        guard let user = Profile.user else { return }
        dateRange = newDate.toWeekRange()
        let result = await repository.fetchHabits(
            by: user.id,
            from: dateRange.start,
            to: dateRange.end,
        )
        switch result {
        case .success(let habits):
            await filterAndSort(habits)
            await updateDate(newDate)
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
        print("HabitWeekViewModel: \(#function) habit=\(id)")
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
            $0.toWeekStatus(current: current, start: dateRange.start, end: dateRange.end)
        }
        
        await sortList(list)
    }
    
    private func updateList(_ newItem: Habit) async {
        var newList = habitStatus.filter { $0.id != newItem.id }
        newList.append(
            newItem.toWeekStatus(current: Date.now, start: dateRange.start, end: dateRange.end)
        )
        await sortList(newList)
    }
    
    private func sortList(_ newList: [HabitWeekStatus]) async {
        await self.setList(newList.sorted(by: <))
    }
    
    @MainActor
    private func setList(_ list: [HabitWeekStatus]) async {
        print("HabitWeekViewModel: \(#function) count = \(list.count)")
        guard habitStatus != list else { return }
        
        habitStatus = list
    }
    
    // MARK: - Date change
    @MainActor
    private func updateDate(_ newDate: Date) async {
        isUpdateDate = true
        date = newDate
        isUpdateDate = false
    }
    
    @MainActor
    private func setLoading(_ show: Bool = true) {
        isLoading = show
    }
    
    // MARK: - Show Message
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitWeekViewModel: message = \(message)")
    }
    
    // MARK: - Subscribe
    private func subscribeReload() {
        repository.needReloadHabitPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(receiveValue: reloadHabit)
            .store(in: &cancellables)
    }
    
}
