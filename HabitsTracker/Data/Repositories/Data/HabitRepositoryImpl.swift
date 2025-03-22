import Foundation
import SwiftData

final class HabitRepositoryImpl: HabitRepository {
    private let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
    
    func fetchHabits() async -> Result<[Habit], any Error> {
        let result = await service.loadHabits()
        return switch result {
        case .success(let habits):
                .success(habits.map { $0.mapToDomain() })
        case .failure(let error):
                .failure(error)
        }
    }
    
    func fetchHabit(id: String) async -> Result<Habit, any Error> {
        let result = await service.loadHabit(id: id)
        return switch result {
        case .success(let habit):
                .success(habit.mapToDomain())
        case .failure(let error):
                .failure(error)
        }
    }
    
    func saveHabit(habit: Habit) async -> Result<Habit, any Error> {
        let userResult = await service.loadUser(id: habit.userId)
        return switch userResult {
        case .success(let user):
            await saveHabit(habit: habit, user: user)
        case .failure(let error):
                .failure(error)
        }
    }
    
    private func saveHabit(habit: Habit, user: UserModel) async -> Result<Habit, any Error> {
        let result = await service.saveHabit(habit: habit.mapToModel(user))
        return switch result {
        case .success(let habitModel):
                .success(habitModel.mapToDomain())
        case .failure(let error):
                .failure(error)
        }
    }
    
    func createUser(name: String) async -> Result<User, any Error> {
        let result = await service.createUser(name: name)
        return switch result {
        case .success(let user):
                .success(user.mapToDomain())
        case .failure(let error):
                .failure(error)
        }
    }
}
