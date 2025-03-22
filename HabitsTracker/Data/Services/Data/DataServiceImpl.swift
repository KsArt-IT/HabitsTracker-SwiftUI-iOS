//
//  DataServiceImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import Foundation
import SwiftData

final class DataServiceImpl: DataService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func createUser(name: String) async -> Result<UserModel, any Error> {
        let user = UserModel(name: name)
        return .success(user)
    }
    
    func loadUser(id: String) async -> Result<UserModel, any Error> {
        .success(UserModel(name: "Mock Name"))
    }
    
    func loadUser(name: String) async -> Result<UserModel, any Error> {
        let user = name == "User" ? UserModel(name: name) : UserModel(name: "Mock Name")
        return .success(user)
    }
    
    func deleteUser(userId: String) async -> Result<Bool, any Error> {
        .success(true)
    }
    
    func loadHabits() async -> Result<[HabitModel], any Error> {
        .success([])
    }
    
    func loadHabit(id: String) async -> Result<HabitModel, any Error> {
        let habit = HabitModel(
            id: id,
            title: "Mock Hobit",
            createdAt: Date.now,
            user: UserModel(name: "Mock Name")
        )
        
        return .success(habit)
    }
    
    func saveHabit(habit: HabitModel) async -> Result<HabitModel, any Error> {
        .success(habit)
    }
    
}
