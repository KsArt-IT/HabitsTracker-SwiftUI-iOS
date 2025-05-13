//
//  NotificationManager.swift
//  HabitsTracker
//
//  Created by KsArT on 13.05.2025.
//

import Foundation
import UserNotifications
import UIKit

final class LocalNotificationManager: NSObject, ObservableObject {
    private let repository: NotificationRepository
    private let notification: NotificationService
    
    @Published private(set) var isPermission = true
    @Published private(set) var isGranted = false
    
    init(repository: NotificationRepository, notification: NotificationService) {
        self.repository = repository
        self.notification = notification
        super.init()
        notification.setDelegate(self)
        checkGranted()
    }
    
    // MARK: - Permission
    func requestPermission() {
        guard !isGranted else { return }
        if isPermission {
            notification.requestPermission()
            isPermission = false
        } else {
            Task { [weak self] in
                await self?.openNotificationSetings()
            }
        }
    }
    
    @MainActor
    private func openNotificationSetings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Granted
    func checkGranted() {
        self.notification.notificationStatus { granted in
            Task { [weak self] in
                await self?.setGranted(granted)
            }
        }
    }
    
    @MainActor
    private func setGranted(_ granted: Bool) {
        isGranted = granted
        print("LocalNotificationManager: isGranted = \(isGranted)")
    }
}

// MARK: - NotificationCenterDelegate
extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    // Показывать уведомления в foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.banner, .sound]
    }
    
    // Обработка нажатия на уведомление
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let identifier = response.notification.request.identifier
        if identifier.starts(with: "habit_") {
            let ids = identifier.components(separatedBy: "_")
            if ids.count > 3, let habitId = UUID(uuidString: ids[1]), let intervalId = UUID(uuidString: ids[3]) {
                print("LocalNotificationManager: \(#function): habitId: \(habitId), intervalId: \(intervalId)")
                switch response.actionIdentifier {
                case NotificationCategory.completedAction:
                    completed(habitId: habitId, intervalId: intervalId)
                case NotificationCategory.laterAction:
                    await notification.later(
                        identifier: "\(response.notification.request.identifier)_later",
                        content: response.notification.request.content,
                        minute: 1
                    )
                default:
                    completed(habitId: habitId, intervalId: intervalId)
                }
            }
        }
    }
    
    private func completed(habitId: UUID, intervalId: UUID) {
        print("LocalNotificationManager: \(#function)")
        Task { [weak self] in
            if let result = await self?.repository.completed(habitId: habitId, intervalId: intervalId),
               result  {
                print("LocalNotificationManager: \(#function): Выполнена задача с ID: \(habitId.debugDescription)")
            }
        }
    }
    
}
