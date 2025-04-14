import Foundation
import SwiftData
import Combine

final class HabitRepositoryImpl: HabitRepository {
    private let service: DataService
    
    var updatePublisher: AnyPublisher<Habit, Never> {
        service.updatePublisher
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    init(service: DataService) {
        self.service = service
    }
    
    
    func fetchHabits(by userId: UUID) async -> Result<[Habit], any Error> {
        let result = await service.loadHabits(by: userId)
        return switch result {
        case .success(let habits):
                .success(habits.map { $0.toDomain() })
        case .failure(let error):
                .failure(error)
        }
    }
    
    func fetchHabit(id: UUID) async -> Result<Habit, any Error> {
        let result = await service.loadHabit(id: id)
        return switch result {
        case .success(let habit):
                .success(habit.toDomain())
        case .failure(let error):
                .failure(error)
        }
    }
    
    func saveHabit(habit: Habit) async -> Result<Habit, any Error> {
        print("HabitRepositoryImpl: \(#function) habit=\(habit.title)")
        let result = await service.saveHabit(habit: habit.toModel())
        return switch result {
        case .success(let habitModel):
                .success(habitModel.toDomain())
        case .failure(let error):
                .failure(error)
        }
    }
    
    func createUser(name: String) async -> Result<User, any Error> {
        let result = await service.createUser(name: name)
        return switch result {
        case .success(let user):
                .success(user.toDomain())
        case .failure(let error):
                .failure(error)
        }
    }
}
