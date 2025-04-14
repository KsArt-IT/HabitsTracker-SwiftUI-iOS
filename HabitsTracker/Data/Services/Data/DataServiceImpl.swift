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
        if case .success(let user) = await loadUser(name: name), let user {
            return .success(user)
        }
        // создадим пользователя
        let user = UserModel(name: name)
        modelContext.insert(user)
        save()
        return .success(user)
    }
    
    func loadUser(id: UUID) async -> Result<UserModel?, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            let users = try loadData(descriptor)
            return .success(users.first)
        } catch {
            return .failure(error)
        }
    }
    
    func loadUser(name: String) async -> Result<UserModel?, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.name == name }
        )
        do {
            let users = try loadData(descriptor)
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
    func loadHabits(by userId: UUID) async -> Result<[HabitModel], any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate { $0.userId == userId }
        )
        do {
            let habits = try loadData(descriptor)
            print("DataServiceImpl: \(#function) habits=\(habits.count)")
            return .success(habits)
        } catch {
            return .failure(error)
        }
    }
    
    func loadHabit(id: UUID) async -> Result<HabitModel, any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            if let habit = try loadData(descriptor).first{
                return .success(habit)
            } else {
                return .failure(CancellationError())
            }
        } catch {
            return .failure(error)
        }
    }
    
    func saveHabit(habit: HabitModel) async -> Result<HabitModel, any Error> {
        print("DataServiceImpl: \(#function) habit=\(habit.title)")
        modelContext.insert(habit)
        save()
        let result = await loadHabit(id: habit.id)
        if case .success(let data) = result {
            updateSubject.send(data)
        }
        return result
    }
    
    func deleteHabit(by id: UUID) async -> Result<Bool, any Error> {
        let descriptor = FetchDescriptor<HabitModel>(
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
    private func loadData<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
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
        let items = try loadData(descriptor)
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
