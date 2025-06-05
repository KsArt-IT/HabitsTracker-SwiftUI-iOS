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
    
    @Published private(set) var isLoading = false
    @Published var habits: [Habit] = []
    @Published var date: Date = Date.now {
        didSet {
            fetchData(from: date)
        }
    }
    
    private var task: Task<(), Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: HabitRepository) {
        self.habitRepository = repository
        // загрузим данные
        fetchData()
        // наблюдаем за добавлением и изменением записей
        subscribeReload()
    }
    
    // MARK: - Fetch Habits
    private func fetchData(from newDate: Date = Date.now) {
        print("HabitDayViewModel: \(#function)")
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
        print("HabitDayViewModel: \(#function) user=\(Profile.user?.id.uuidString ?? "")")
        guard let user = Profile.user else { return }
        let result = await habitRepository.fetchHabits(by: user.id, from: newDate)
        switch result {
        case .success(let habits):
            await sortList(habits)
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
        print("HabitDayViewModel: \(#function) habit=\(id)")
        let result = await habitRepository.fetchHabit(by: id, from: date)
        switch result {
        case .success(nil):
            // удалим из списка
            await setList(habits.filter { $0.id != id })
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
        let result = await habitRepository.deleteHabit(by: id)
        switch result {
        case .success(_):
            await setList(habits.filter { $0.id != id })
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    // MARK: - Update List
    private func updateList(_ newItem: Habit) async {
        var newList = habits.filter { $0.id != newItem.id }
        newList.append(newItem)
        await sortList(newList)
    }
    
    private func sortList(_ newList: [Habit]) async {
        await setList(newList.sorted(by: <))
    }
    
    @MainActor
    private func setList(_ list: [Habit]) {
        print("HabitDayViewModel: \(#function) count = \(list.count)")
        guard habits != list else { return }
        
        habits = list
    }
    
    // MARK: - Date change
    func changeDate(_ newDate: Date) {
        date = newDate
        fetchData(from: newDate)
    }
    
    @MainActor
    private func setLoading(_ show: Bool = true) {
        isLoading = show
    }
    
    // MARK: - Show Message
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitDayViewModel: message = \(message)")
    }
    
    // MARK: - Subscribe
    private func subscribeReload() {
        habitRepository.needReloadHabitPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(receiveValue: reloadHabit)
            .store(in: &cancellables)
    }
    
}
