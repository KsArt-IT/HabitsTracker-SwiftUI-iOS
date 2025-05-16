//
//  NotificationRepositoryImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 12.05.2025.
//

import Foundation
import UserNotifications

final class NotificationRepositoryImpl: NotificationRepository {
    private let dataService: DataService
    private let notificationService: NotificationService

    init(dataService: DataService, notificationService: NotificationService) {
        self.dataService = dataService
        self.notificationService = notificationService
    }
    
    func completed(habitId: UUID, intervalId: UUID) async -> Bool {
        print("NotificationRepositoryImpl: \(#function)")
        if let interval = await dataService.fetchInterval(habitId: habitId, intervalId: intervalId) {
            if (await dataService.fetchCompleted(habitId: habitId, intervalId: intervalId, date: Date.now)) == nil {
                let completed = HourIntervalCompletedModel(
                    habitId: habitId,
                    intervalId: interval.id,
                    time: interval.time,
                )
                if case .success(_) = await dataService.saveCompleted(completed) {
                    // оповестим, что нужно обновить habit
                    dataService.reloadHabit(by: habitId)
                    return true
                }
            }
        }
        return false
    }

    func setDelegate(_ delegate: any UNUserNotificationCenterDelegate) {
        notificationService.setDelegate(delegate)
    }
    
    func notificationStatus(_ setStatus: @escaping (Bool) -> Void) {
        notificationService.notificationStatus(setStatus)
    }
    
    func requestPermission() {
        notificationService.requestPermission()
    }
    
    func later(identifier: String, content: UNNotificationContent, minute: Int) async {
        await notificationService.later(identifier: identifier, content: content, minute: minute)
    }
    
    func schedule(_ title: String, for notifications: [HabitNotification]) async {
        await notificationService.schedule(title, for: notifications)
    }
    
    func cancel(for notifications: [HabitNotification]) async {
        await notificationService.cancel(for: notifications)
    }
    
}
