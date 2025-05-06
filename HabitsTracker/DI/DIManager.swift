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

    // MARK: DataRepository
    private func registerUserRepository() {
        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(service: resolver.resolve(DataService.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerDataRepository() {
        container.register(HabitRepository.self) { resolver in
            HabitRepositoryImpl(service: resolver.resolve(DataService.self)!)
        }.inObjectScope(.container)
    }
    
    // MARK: - ViewModel
    private func registerOnboardViewModel() {
        container.register(OnboardViewModel.self) { resolver in
            OnboardViewModel(repository: resolver.resolve(UserRepository.self)!)
        }.inObjectScope(.weak)
    }
    
    private func registerHabitCreateViewModel() {
        container.register(HabitCreateViewModel.self) { resolver in
            HabitCreateViewModel(repository: resolver.resolve(HabitRepository.self)!)
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
        container.register(HabitWeekViewModel.self) { c in
            HabitWeekViewModel()
        }.inObjectScope(.weak)
    }
    
    private func registerHabitMonthViewModel() {
        container.register(HabitMonthViewModel.self) { c in
            HabitMonthViewModel()
        }.inObjectScope(.weak)
    }
    
    private func registerSettingsViewModel() {
        container.register(SettingsViewModel.self) { c in
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
