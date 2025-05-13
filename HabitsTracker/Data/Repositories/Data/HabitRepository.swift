import Foundation
import SwiftData
import Combine

protocol HabitRepository: AnyObject {
    func fetchHabits(by userId: UUID, from date: Date) async -> Result<[Habit], any Error>
    func fetchHabits(by userId: UUID, from startDate: Date, to endDate: Date) async -> Result<[Habit], any Error>
    
    func fetchHabit(by id: UUID, from date: Date) async -> Result<Habit?, any Error>
    func fetchHabit(by id: UUID, from startDate: Date, to endDate: Date) async -> Result<Habit?, any Error>

    func saveHabit(_ habit: Habit) async -> Result<Bool, any Error>
    func deleteHabit(by id: UUID) async -> Result<Bool, any Error>
    
    func fetchCompleteds(by habitId: UUID) async -> Result<[HourIntervalCompleted], any Error>
    func fetchCompleteds(by habitId: UUID, from date: Date) async -> Result<[HourIntervalCompleted], any Error>
    func fetchCompleteds(
        by habitId: UUID,
        from startDate: Date,
        to endDate: Date
    ) async -> Result<[HourIntervalCompleted], any Error>
    func saveCompleted(
        by habitId: UUID,
        completed: HourIntervalCompleted
    ) async -> Result<HourIntervalCompleted, any Error>
    func deleteCompleted(by id: UUID) async -> Result<Bool, any Error>
    
    func reloadHabit(by id: UUID)
    var needReloadHabitPublisher: AnyPublisher<UUID, Never> { get }
}
