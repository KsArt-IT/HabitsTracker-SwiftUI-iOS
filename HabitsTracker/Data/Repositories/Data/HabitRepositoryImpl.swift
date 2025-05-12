//
//  HabitRepositoryImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import Foundation
import SwiftData
import Combine

final class HabitRepositoryImpl: HabitRepository {
    private let service: DataService
    private let notificationService: NotificationService
    
    var needReloadHabitPublisher: AnyPublisher<UUID, Never> {
        service.needReloadHabitPublisher
    }
    
    init(service: DataService, notificationService: NotificationService) {
        self.service = service
        self.notificationService = notificationService
    }
    
    
    func fetchHabits(by userId: UUID, from date: Date) async -> Result<[Habit], any Error> {
        await fetchHabits(by: userId, from: date, to: date)
    }
    
    func fetchHabits(by userId: UUID, from startDate: Date, to endDate: Date) async -> Result<[Habit], any Error> {
        let result = await service.fetchHabits(by: userId, from: startDate, to: endDate)
        return switch result {
        case .success(let habits):
                .success(habits.map { $0.toDomain() })
        case .failure(let error):
                .failure(error)
        }
    }
    
    func fetchHabit(by id: UUID, from date: Date) async -> Result<Habit?, any Error> {
        await fetchHabit(by: id, from: date, to: date)
    }
    
    func fetchHabit(by id: UUID, from startDate: Date, to endDate: Date) async -> Result<Habit?, any Error> {
        let result = await service.fetchHabit(by: id, from: startDate, to: endDate)
        return switch result {
        case .success(nil):
                .success(nil)
        case .success(let habit):
                .success(habit!.toDomain())
        case .failure(let error):
                .failure(error)
        }
    }
    
    func reloadHabit(by id: UUID) {
        service.reloadHabit(by: id)
    }
    
    func saveHabit(_ habit: Habit) async -> Result<Bool, any Error> {
        // удалить нотификацию
        await deleteNotifications(by: habit.id)
        // добавить новые
        await notificationService.activate(habit.title, for: habit.notifications)
        // сохранить
        return await service.saveHabit(habit.toModel())
    }
    
    func deleteHabit(by id: UUID) async -> Result<Bool, any Error> {
        // удалить нотификацию
        await deleteNotifications(by: id)
        // удалить habit
        return await service.deleteHabit(by: id)
    }
    
    // MARK: - HourIntervalCompleted
    func fetchCompleteds(by habitId: UUID) async -> Result<[HourIntervalCompleted], any Error> {
        let result = await service.fetchCompleteds(by: habitId)
        return switch result {
        case .success(let completeds):
                .success(completeds.map { $0.toDomain() })
        case .failure(let error):
                .failure(error)
        }
    }
    
    func fetchCompleteds(by habitId: UUID, from date: Date) async -> Result<[HourIntervalCompleted], any Error> {
        await fetchCompleteds(by: habitId, from: date, to: date)
    }
    
    func fetchCompleteds(by habitId: UUID, from startDate: Date, to endDate: Date) async -> Result<[HourIntervalCompleted], any Error> {
        let result = await service.fetchCompleteds(by: habitId, from: startDate, to: endDate)
        return switch result {
        case .success(let completeds):
                .success(completeds.map { $0.toDomain() })
        case .failure(let error):
                .failure(error)
        }
    }
    
    func saveCompleted(by habitId: UUID, completed: HourIntervalCompleted) async -> Result<HourIntervalCompleted, any Error> {
        // удалить на сегодня оповещение
        
        //
        let result = await service.saveCompleted(completed.toModel(habitId: habitId))
        return switch result {
        case .success(let completed):
                .success(completed.toDomain())
        case .failure(let error):
                .failure(error)
        }
        
    }
    
    func deleteCompleted(by id: UUID) async -> Result<Bool, any Error> {
        await service.deleteCompleted(by: id)
    }
    
    // MARK: - Notification
    func notificationStatus() -> Bool {
        notificationService.notificationStatus()
    }
    
    func requestPermission() {
        notificationService.requestPermission()
    }
    
    private func deleteNotifications(by habitId: UUID) async {
        // получить все оповещения для id
        let notifications = await service.fetchNotifications(by: habitId)
        // удалить нотификацию
        await notificationService.deactivate(for: notifications.map { $0.toDomain() })
    }
    
}
