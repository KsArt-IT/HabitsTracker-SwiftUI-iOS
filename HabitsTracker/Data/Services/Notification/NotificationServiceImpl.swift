//
//  NotificationServiceImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 10.05.2025.
//

import Foundation
import UserNotifications

final class NotificationServiceImpl: NotificationService {
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notifications: Error requesting notifications: \(error)")
            } else if granted {
                print("Notifications: granted")
            } else {
                print("Notifications: denied")
            }
        }
    }
    
    func notificationStatus() -> Bool {
        var result = false
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                print("Notifications: Yes")
                result = true
            } else {
                print("Notifications: No")
            }
        }
        return result
    }
    
    func activate(_ title: String, for notifications: [HabitNotification]) async {
        guard !notifications.isEmpty else { return }
        
        for notification in notifications {
            var dateComponents = DateComponents()
            if notification.weekDay != WeekDays.allDays {
                dateComponents.weekday = notification.weekDay
            }
            dateComponents.hour = notification.time.hours
            dateComponents.minute = notification.time.minutes
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: notification.repeats)
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = "It's time to do it!"
            content.sound = .default
            content.categoryIdentifier = NotificationDelegate.category
            
            let request = UNNotificationRequest(
                identifier: notification.identifier,
                content: content,
                trigger: trigger
            )
            print("Notifications: time=\(String(describing: dateComponents.hour)):\(String(describing: dateComponents.minute)) - \(dateComponents)")
            try? await UNUserNotificationCenter.current().add(request)
        }
    }
    
    func deactivate(for notifications: [HabitNotification]) async {
        guard !notifications.isEmpty else { return }
        
        let allIDs = notifications.map { $0.identifier }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: allIDs)
    }
    
    func deleteAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
