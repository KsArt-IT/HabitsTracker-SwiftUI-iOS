import Foundation
import SwiftData

protocol HabitRepository: AnyObject {
    func fetchHabits() async -> Result<[Habit], any Error>
    func fetchHabit(id: UUID) async -> Result<Habit, any Error>
    func saveHabit(habit: Habit, user: User) async -> Result<Habit, any Error>
}
