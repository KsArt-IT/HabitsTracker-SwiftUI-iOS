//
//  UserRepositoryImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
    
    func createUser(name: String) async -> Result<User, any Error> {
        let result =  await service.createUser(name: name)
        return switch result {
        case .success(let user):
                .success(user.toDomain())
        case .failure(let error):
                .failure(error)
        }
    }
    
    func loadUser(name: String) async -> Result<User?, any Error> {
        let result =  await service.fetchUser(by: name)
        return switch result {
        case .success(let user):
                .success(user?.toDomain())
        case .failure(let error):
                .failure(error)
        }
    }
}
