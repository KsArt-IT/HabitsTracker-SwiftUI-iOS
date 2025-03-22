//
//  HabitModel.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation
import SwiftData

@Model
final class HabitModel {
    @Attribute(.unique)
    var id: String
    var title: String
    var createdAt: Date
    
    // Связь с UserModel, при удалении пользователя, удаляется и запись
    @Relationship(deleteRule: .cascade)
    var user: UserModel
    
    init(
        id: String,
        title: String,
        createdAt: Date,
        user: UserModel
    ) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        
        self.user = user
    }
}

extension HabitModel {
    func mapToDomain() -> Habit {
        Habit(
            id: self.id,
            title: self.title,
            createdAt: self.createdAt,
            userId: self.user.id
        )
    }
}

extension Habit {
    func mapToModel(_ user: UserModel) -> HabitModel {
        HabitModel(
            id: self.id,
            title: self.title,
            createdAt: self.createdAt,
            user: user
        )
    }
}
