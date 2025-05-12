//
//  NotificationDelegate.swift
//  HabitsTracker
//
//  Created by KsArT on 12.05.2025.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let category = "HABIT_CATEGORY"
    static let completedAction = "HABIT_COMPLETE_ACTION"
    static let laterAction = "HABIT_REMIND_LATER_ACTION"
    
    private let repository: NotificationRepository
    
    init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    func getCategories() -> UNNotificationCategory {
        print("NotificationDelegate: \(#function)")
        let completeAction = UNNotificationAction(
            identifier: NotificationDelegate.completedAction,
            title: "Mark as done",
            options: []
//            options: [.authenticationRequired]
        )

        let remindLaterAction = UNNotificationAction(
            identifier: NotificationDelegate.laterAction,
            title: "Remind me later",
            options: []
        )

        let category = UNNotificationCategory(
            identifier: NotificationDelegate.category,
            actions: [completeAction, remindLaterAction],
            intentIdentifiers: [],
            options: []
        )
        
        return category
    }
    
    // Показывать уведомления в foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("NotificationDelegate: \(#function)")
        completionHandler([.banner, .sound])
    }
    
    // Обработка нажатия на уведомление
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let identifier = response.notification.request.identifier
        print("-----------------------------------------------")
        print("NotificationDelegate: \(#function): identifier: \(identifier)")
        
        if identifier.starts(with: "habit_") {
            let ids = identifier.components(separatedBy: "_")
            if ids.count > 3, let habitId = UUID(uuidString: ids[1]), let intervalId = UUID(uuidString: ids[3]) {
                print("NotificationDelegate: \(#function): habitId: \(habitId), intervalId: \(intervalId)")
                switch response.actionIdentifier {
                case NotificationDelegate.completedAction:
                    completed(habitId: habitId, intervalId: intervalId)
                case NotificationDelegate.laterAction:
                    print("NotificationDelegate: \(#function): later")
                default:
                    print("NotificationDelegate: \(#function): default")
                    completed(habitId: habitId, intervalId: intervalId)
                }
            }
        }
        print("-----------------------------------------------")

        completionHandler()
    }
    
    private func completed(habitId: UUID, intervalId: UUID) {
        print("NotificationDelegate: \(#function): use")
        Task { [weak self] in
            if let result = await self?.repository.completed(habitId: habitId, intervalId: intervalId),
               result  {
                print("NotificationDelegate: \(#function): Выполнена задача с ID: \(habitId.debugDescription)")
            }
        }
    }
}
