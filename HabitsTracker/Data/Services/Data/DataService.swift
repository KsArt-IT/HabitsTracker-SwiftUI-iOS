//
//  DataService.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import Foundation
import Combine

protocol DataService: AnyObject {
    func fetchHabits(by userId: UUID) async -> Result<[HabitModel], any Error>
    func fetchHabits(by userId: UUID, from startDate: Date, to endDate: Date) async -> Result<[HabitModel], any Error>
    
    func fetchHabit(by id: UUID) async -> Result<HabitModel, any Error>
    func fetchHabit(by id: UUID, from startDate: Date, to endDate: Date) async -> Result<HabitModel?, any Error>

    func saveHabit(_ habit: HabitModel) async -> Result<HabitModel, any Error>
    func deleteHabit(by id: UUID) async -> Result<Bool, any Error>
    
    func fetchCompleteds(by habitId: UUID) async -> Result<[HourIntervalCompletedModel], any Error>
    func fetchCompleteds(by habitId: UUID, from startDate: Date, to endDate: Date) async -> Result<[HourIntervalCompletedModel], any Error>
    func saveCompleted(_ completed: HourIntervalCompletedModel) async -> Result<HourIntervalCompletedModel, any Error>
    func deleteCompleted(by id: UUID) async -> Result<Bool, any Error>
    
    func createUser(name: String) async -> Result<UserModel, any Error>
    func fetchUser(by id: UUID) async -> Result<UserModel?, any Error>
    func fetchUser(by name: String) async -> Result<UserModel?, any Error>
    func deleteUser(by id: UUID) async -> Result<Bool, any Error>
    
    func reloadHabit(by id: UUID)
    var updatePublisher: AnyPublisher<HabitModel, Never> { get }
    var needReloadHabitPublisher: AnyPublisher<UUID, Never> { get }
}
