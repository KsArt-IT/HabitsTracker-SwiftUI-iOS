//
//  UserRepository.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

protocol UserRepository: AnyObject {
    func createUser(name: String) async -> Result<User, any Error>
    func loadUser(name: String) async -> Result<User?, any Error>
}
