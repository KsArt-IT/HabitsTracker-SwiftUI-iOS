//
//  Repository.swift
//  HabitsTracker
//
//  Created by KsArT on 12.05.2025.
//

import Foundation
import UserNotifications

protocol NotificationRepository {
    func completed(habitId: UUID, intervalId: UUID) async -> Bool
    
    func setDelegate(_ delegate: any UNUserNotificationCenterDelegate)
    func notificationStatus(_ setStatus: @escaping (Bool) -> Void)
    func requestPermission()
    func later(identifier: String, content: UNNotificationContent, minute: Int) async
    func schedule(_ title: String, for notifications: [HabitNotification]) async
    func cancel(for notifications: [HabitNotification]) async
}
