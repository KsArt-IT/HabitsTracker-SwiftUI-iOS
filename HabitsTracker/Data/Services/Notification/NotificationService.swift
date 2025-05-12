//
//  NotificationService.swift
//  HabitsTracker
//
//  Created by KsArT on 10.05.2025.
//

import Foundation

protocol NotificationService {
    func notificationStatus() -> Bool
    func requestPermission()
    func activate(_ title: String, for notifications: [HabitNotification]) async
    func deactivate(for notifications: [HabitNotification]) async
}
