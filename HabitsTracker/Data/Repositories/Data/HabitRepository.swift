import Foundation
import SwiftData

protocol HabitRepository: AnyObject {
    func fetchHabits() async -> Result<[Habit], any Error>
    func fetchHabit(id: String) async -> Result<Habit, any Error>
    func saveHabit(habit: Habit) async -> Result<Habit, any Error>
}
