//
//  DIManager.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import Foundation
import Swinject

final class DIManager {
    private let container = Container()
    
    init() {
        registerDataBase()
        
        registerNotificationService()
        registerNotificationRepository()
        registerNotificationManager()
        
        registerUserRepository()
        registerDataRepository()
        
        registerOnboardViewModel()
        
        registerHabitCreateViewModel()
        
        registerHabitActionViewModel()
        
        registerHabitDayViewModel()
        registerHabitWeekViewModel()
        registerHabitMonthViewModel()
        registerSettingsViewModel()
    }
    
    // MARK: DataBase
    private func registerDataBase() {
        container.register(DataBase.self) { _ in
            DataBase()
        }.inObjectScope(.weak)
        
        container.register(DataService.self) { resolver in
            let db = resolver.resolve(DataBase.self)!
            return DataServiceImpl(modelContext: db.context)
        }.inObjectScope(.weak)
    }
    
    // MARK: Notification
    private func registerNotificationService() {
        container.register(NotificationService.self) { _ in
            NotificationServiceImpl()
        }.inObjectScope(.weak)
    }
    
    private func registerNotificationRepository() {
        container.register(NotificationRepository.self) { resolver in
            NotificationRepositoryImpl(service: resolver.resolve(DataService.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerNotificationManager() {
        container.register(LocalNotificationManager.self) { resolver in
            LocalNotificationManager(
                repository: resolver.resolve(NotificationRepository.self)!,
                notification: resolver.resolve(NotificationService.self)!,
            )
        }.inObjectScope(.container)
    }
    
    // MARK: Repository
    private func registerUserRepository() {
        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(service: resolver.resolve(DataService.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerDataRepository() {
        container.register(HabitRepository.self) { resolver in
            HabitRepositoryImpl(
                service: resolver.resolve(DataService.self)!,
                notificationService: resolver.resolve(NotificationService.self)!
            )
        }.inObjectScope(.container)
    }
    
    // MARK: - ViewModel
    private func registerOnboardViewModel() {
        container.register(OnboardViewModel.self) { resolver in
            OnboardViewModel(repository: resolver.resolve(UserRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerHabitCreateViewModel() {
        container.register(HabitEditViewModel.self) { resolver in
            HabitEditViewModel(repository: resolver.resolve(HabitRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerHabitActionViewModel() {
        container.register(HabitActionViewModel.self) { resolver in
            HabitActionViewModel(repository: resolver.resolve(HabitRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerHabitDayViewModel() {
        container.register(HabitDayViewModel.self) { resolver in
            HabitDayViewModel(repository: resolver.resolve(HabitRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerHabitWeekViewModel() {
        container.register(HabitWeekViewModel.self) { resolver in
            HabitWeekViewModel(repository: resolver.resolve(HabitRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerHabitMonthViewModel() {
        container.register(HabitMonthViewModel.self) { resolver in
            HabitMonthViewModel(repository: resolver.resolve(HabitRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerSettingsViewModel() {
        container.register(SettingsViewModel.self) { resolver in
            SettingsViewModel()
        }.inObjectScope(.weak)
    }
    
    // MARK: - Getting dependencies
    public func resolve<T>() -> T {
        resolve(T.self)!
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        container.resolve(type)
    }
}
