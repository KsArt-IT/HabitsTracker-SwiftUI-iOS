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
    
    private let updateSubject = PassthroughSubject<HabitModel, Never>()
    public var updatePublisher: AnyPublisher<HabitModel, Never> {
        updateSubject.eraseToAnyPublisher()
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
    
    // MARK: - Habit
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
    
    func saveHabit(_ habit: HabitModel) async -> Result<HabitModel, any Error> {
        print("DataServiceImpl: \(#function) habit=\(habit.title)")
        modelContext.insert(habit)
        save()
        updateSubject.send(habit)
        return .success(habit)
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
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - HourIntervalCompletedModel
    func fetchCompleteds(by habitId: UUID) async -> Result<[HourIntervalCompletedModel], any Error> {
        let descriptor = FetchDescriptor<HourIntervalCompletedModel>(
            predicate: #Predicate { $0.habitId == habitId }
        )
        do {
            let completeds = try fetchData(descriptor)
            print("DataServiceImpl: \(#function) habits=\(completeds.count)")
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
            print("DataServiceImpl: \(#function) intervals=\(completed.count)")
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
    
    // MARK: - Load
    private func fetchData<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try modelContext.fetch(descriptor)
    }
    
    // MARK: - Delete
    @MainActor
    func deleteData<T: PersistentModel>(_ item: T) {
        modelContext.delete(item)
        save()
    }
    
    @MainActor
    func deleteData<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws {
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
