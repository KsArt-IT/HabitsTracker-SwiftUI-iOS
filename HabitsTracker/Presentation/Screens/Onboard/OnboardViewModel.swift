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
        print("OnboardViewModel: \(#function)")
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
    
    private func loadUser(_ name: String) async -> User? {
        print("OnboardViewModel: \(#function)")
        let result = await repository.loadUser(name: name)
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            await showMessage(error.localizedDescription)
            return nil
        }
    }
    
    private func createUser(_ name: String) async -> User? {
        print("OnboardViewModel:\(#function)")
        guard !name.isEmpty else { return nil }
        
        let result = await repository.createUser(name: name)
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            await showMessage(error.localizedDescription)
            return nil
        }
    }
    
    @MainActor
    private func initProfile(_ user: User?) async {
        print("OnboardViewModel:\(#function): user = \(user?.name ?? "")")
        if let user {
            Profile.login(user)
            initialized = true
        } else {
            needName = true
        }
    }
    
    @MainActor
    private func showMessage(_ message: String) {
        print("OnboardViewModel: message = \(message)")
    }
    
}
