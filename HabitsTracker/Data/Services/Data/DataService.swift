//
//  DataService.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import Foundation

protocol DataService: AnyObject {
    func loadHabits() async -> Result<[HabitModel], any Error>
    func loadHabit(id: UUID) async -> Result<HabitModel, any Error>
    
    func saveHabit(habit: HabitModel) async -> Result<HabitModel, any Error>
    
    func createUser(name: String) async -> Result<UserModel, any Error>
    func loadUser(id: UUID) async -> Result<UserModel, any Error>
    func loadUser(name: String) async -> Result<UserModel, any Error>
    func deleteUser(by id: UUID) async -> Result<Bool, any Error>
}
