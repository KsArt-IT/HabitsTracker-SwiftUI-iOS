//
//  HelloViewModel.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

final class OnboardViewModel: ObservableObject {
    private let repository: UserRepository
    @Published var needName: Bool = false
    @Published var initialized: Bool = false
    private var task: Task<(), Never>?
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    public func initialize(name: String) {
        guard task == nil else { return }
        
        let newTask = Task { [weak self] in
            var user = await self?.loadUser(name)
            if user == nil {
                user = await self?.createUser(name)
            }
            await self?.initProfile(user)
            
            self?.task = nil
        }
        self.task = newTask
    }
    
    @MainActor
    private func initProfile(_ user: User?) async {
        print("user= \(user?.name ?? "")")
        if let user, user.name != "Mock Name" {
            Profile.login(user)
            initialized = true
        } else {
            needName = true
        }
    }
    
    private func loadUser(_ name: String) async -> User? {
        let result = await repository.loadUser(name: name)
        return switch result {
        case .success(let user):
            user
        case .failure(let error):
            nil
        }
    }
    
    private func createUser(_ name: String) async -> User? {
        let result = await repository.loadUser(name: name)
        return switch result {
        case .success(let user):
            user
        case .failure(let error):
            nil
        }
    }
}
