//
//  Repository.swift
//  HabitsTracker
//
//  Created by KsArT on 12.05.2025.
//

import Foundation

protocol NotificationRepository {
    func completed(habitId: UUID, intervalId: UUID) async -> Bool
}
