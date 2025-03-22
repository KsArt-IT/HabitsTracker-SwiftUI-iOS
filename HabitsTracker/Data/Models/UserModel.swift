//
//  UserModel.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation
import SwiftData

@Model
final class UserModel {
    @Attribute(.unique)
    var id: String
    @Attribute(.unique)
    var name: String
    
    init(
        id: String = UUID().uuidString,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

extension UserModel {
    func mapToDomain() -> User {
        User(
            id: self.id,
            name: self.name
        )
    }
}
