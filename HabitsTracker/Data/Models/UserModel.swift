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
    var id: UUID
    var name: String
    var createdAt: Date
    
    init(
        id: UUID = UUID(),
        name: String,
        createdAt: Date = Date.now
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}
