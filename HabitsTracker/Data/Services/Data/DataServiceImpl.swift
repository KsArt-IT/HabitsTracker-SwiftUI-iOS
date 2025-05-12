//
//  DataServiceImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import Foundation
import SwiftData
import Combine

final class DataServiceImpl: DataService {
    private let modelContext: ModelContext
    
    private let needReloadHabitSubject = PassthroughSubject<UUID, Never>()
    public var needReloadHabitPublisher: AnyPublisher<UUID, Never> {
        needReloadHabitSubject.eraseToAnyPublisher()
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - User
    func createUser(name: String) async -> Result<UserModel, any Error> {
        // если пользователь есть, вернем
        if case .success(let user) = await fetchUser(by: name), let user {
            return .success(user)
        }
        // создадим пользователя
        let user = UserModel(name: name)
        modelContext.insert(user)
        save()
        return .success(user)
    }
    
    func fetchUser(by id: UUID) async -> Result<UserModel?, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            let users = try fetchData(descriptor)
            return .success(users.first)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchUser(by name: String) async -> Result<UserModel?, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.name == name }
        )
        do {
            let users = try fetchData(descriptor)
            return .success(users.first)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteUser(by id: UUID) async -> Result<Bool, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            // TODO: - необходимо, наверноу, удалить все данные пользователя
            try await deleteData(descriptor)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Habits
    func fetchHabits(by userId: UUID) async -> Result<[HabitModel], any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate { $0.userId == userId }
        )
        do {
            let habits = try fetchData(descriptor)
            for (index, habit) in habits.enumerated() {
                if case .success(let completed) = await fetchCompleteds(by: habit.id) {
                    habits[index].completed = completed
                }
            }
            print("DataServiceImpl: \(#function) habits=\(habits.count)")
            return .success(habits)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchHabits(by userId: UUID, from startDate: Date, to endDate: Date) async -> Result<[HabitModel], any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate {
                $0.userId == userId && $0.createdAt <= endDate.endOfDay && $0.completedAt >= startDate.startOfDay
            }
        )
        do {
            let habits = try fetchData(descriptor)
            for (index, habit) in habits.enumerated() {
                if case .success(let completed) = await fetchCompleteds(by: habit.id, from: startDate, to: endDate) {
                    habits[index].completed = completed
                }
            }
            print("DataServiceImpl: \(#function) habits=\(habits.count)")
            return .success(habits)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Habit
    func fetchHabit(by id: UUID) async -> Result<HabitModel, any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            if let habit = try fetchData(descriptor).first {
                if case .success(let completed) = await fetchCompleteds(by: habit.id) {
                    habit.completed = completed
                }
                return .success(habit)
            } else {
                return .failure(CancellationError())
            }
        } catch {
            return .failure(error)
        }
    }
    
    func fetchHabit(by id: UUID, from startDate: Date, to endDate: Date) async -> Result<HabitModel?, any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate {
                $0.id == id && $0.createdAt <= endDate.endOfDay && $0.completedAt >= startDate.startOfDay
            }
        )
        do {
            if let habit = try fetchData(descriptor).first {
                if case .success(let completed) = await fetchCompleteds(by: habit.id, from: startDate, to: endDate) {
                    habit.completed = completed
                }
                print("DataServiceImpl: \(#function) habit=\(habit.title), notification=\(habit.notifications.count)")
                return .success(habit)
            }
            // если был перед этим удален
            return .success(nil)
        } catch {
            return .failure(error)
        }
    }
    
    private func deleteHabitOld(_ id: UUID) throws {
        print("DataServiceImpl: \(#function)")
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate { $0.id == id }
        )
        let items = try fetchData(descriptor)
        for item in items {
            for interval in item.intervals {
                modelContext.delete(interval)
            }
            for notification in item.notifications {
                modelContext.delete(notification)
            }
            modelContext.delete(item)
        }
    }
    
    func saveHabit(_ habit: HabitModel) async -> Result<Bool, any Error> {
        print("DataServiceImpl: \(#function)")
        do {
            // Удалим если был такой и добавим новый
            try deleteHabitOld(habit.id)
            // Записываем новый
            modelContext.insert(habit)
            print("DataServiceImpl: \(#function) insert")
            // Сохраняем изменения
            save()
            print("DataServiceImpl: \(#function) save")
            // Уведомляем об обновлении
            needReloadHabitSubject.send(habit.id)
            print("DataServiceImpl: \(#function) habit=\(habit.id)")
            return .success(true)
        } catch {
            print("DataServiceImpl: \(#function) error: \(error)")
            return .failure(error)
        }
    }
    
    func deleteHabit(by id: UUID) async -> Result<Bool, any Error> {
        // удалить habit и интервалы
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate { $0.id == id }
        )
        // удалить завершенные интервалы
        let descriptorCompleted = FetchDescriptor<HourIntervalCompletedModel>(
            predicate: #Predicate { $0.habitId == id }
        )
        do {
            try await deleteData(descriptor)
            try await deleteData(descriptorCompleted)
            // необходимо обновить
            needReloadHabitSubject.send(id)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func reloadHabit(by id: UUID) {
        print("DataServiceImpl: \(#function) habit=\(id)")
        needReloadHabitSubject.send(id)
    }
    
    // MARK: - HourIntervalModel
    func fetchInterval(habitId: UUID, intervalId: UUID) async -> HourIntervalModel? {
        let descriptor = FetchDescriptor<HourIntervalModel>(
            predicate: #Predicate { $0.habit?.id == habitId && $0.id == intervalId }
        )
        return try? fetchData(descriptor).first
    }
    
    // MARK: - HourIntervalCompletedModel
    func fetchCompleted(habitId: UUID, intervalId: UUID, date: Date) async -> HourIntervalCompletedModel? {
        let descriptor = FetchDescriptor<HourIntervalCompletedModel>(
            predicate: #Predicate {
                $0.habitId == habitId && $0.intervalId == intervalId &&
                $0.completedAt >= date.startOfDay && $0.completedAt <= date.endOfDay
            }
        )
        return try? fetchData(descriptor).first
    }
    
    func fetchCompleteds(by habitId: UUID) async -> Result<[HourIntervalCompletedModel], any Error> {
        let descriptor = FetchDescriptor<HourIntervalCompletedModel>(
            predicate: #Predicate { $0.habitId == habitId }
        )
        do {
            let completeds = try fetchData(descriptor)
            return .success(completeds)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchCompleteds(by habitId: UUID, from startDate: Date, to endDate: Date) async -> Result<[HourIntervalCompletedModel], any Error> {
        let descriptor = FetchDescriptor<HourIntervalCompletedModel>(
            predicate: #Predicate {
                $0.habitId == habitId && $0.completedAt >= startDate.startOfDay && $0.completedAt <= endDate.endOfDay
            }
        )
        do {
            let completed = try fetchData(descriptor)
            return .success(completed)
        } catch {
            return .failure(error)
        }
    }
    
    func saveCompleted(_ completed: HourIntervalCompletedModel) async -> Result<HourIntervalCompletedModel, any Error> {
        modelContext.insert(completed)
        save()
        return .success(completed)
    }
    
    func deleteCompleted(by id: UUID) async -> Result<Bool, any Error> {
        let descriptor = FetchDescriptor<HourIntervalCompletedModel>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            try await deleteData(descriptor)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Notifications
    func fetchNotifications(by habitId: UUID) async -> [HabitNotificationModel] {
        do {
            let descriptor = FetchDescriptor<HabitNotificationModel>(
                predicate: #Predicate { $0.id == habitId }
            )
            
            return try fetchData(descriptor)
        } catch {
            print("DataServiceImpl: \(#function) error: \(error)")
            return []
        }
    }
    
    // MARK: - Load
    private func fetchData<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try modelContext.fetch(descriptor)
    }
    
    // MARK: - Delete
    private func deleteData<T: PersistentModel>(_ item: T) {
        modelContext.delete(item)
        save()
    }
    
    private func deleteData<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) async throws {
        let items = try fetchData(descriptor)
        guard !items.isEmpty else { return }
        for item in items {
            modelContext.delete(item)
        }
        save()
    }
    
    // MARK: - Save
    private func save(_ force: Bool = false) {
        do {
            if force || modelContext.hasChanges {
                try modelContext.save()
                print("DataServiceImpl: \(#function)")
            }
        } catch {
            print("DataServiceImpl: \(#function) error: \(error)")
        }
    }
    
}
