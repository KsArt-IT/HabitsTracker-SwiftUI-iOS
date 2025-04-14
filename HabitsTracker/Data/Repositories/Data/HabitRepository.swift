import Foundation
import SwiftData
import Combine

protocol HabitRepository: AnyObject {
    func fetchHabits(by userId: UUID) async -> Result<[Habit], any Error>
    func fetchHabit(id: UUID) async -> Result<Habit, any Error>
    func saveHabit(habit: Habit) async -> Result<Habit, any Error>
    
    var updatePublisher: AnyPublisher<Habit, Never> { get }
}
