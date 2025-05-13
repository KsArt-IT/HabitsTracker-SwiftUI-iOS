//
//  NotificationServiceImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 10.05.2025.
//

import Foundation
import UserNotifications

final class NotificationServiceImpl: NotificationService {
    private let center: UNUserNotificationCenter
    
    init(center: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.center = center
    }
    
    func setDelegate(_ delegate: any UNUserNotificationCenterDelegate) {
        center.setNotificationCategories(NotificationCategory.categories)
        center.delegate = delegate
    }
    
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notifications: Error requesting notifications: \(error)")
            } else if granted {
                print("Notifications: granted")
            } else {
                print("Notifications: denied")
            }
        }
    }
    
    func notificationStatus(_ setStatus: @escaping (Bool) -> Void) {
        center.getNotificationSettings { settings in
            setStatus(settings.authorizationStatus == .authorized)
        }
    }
    
    func schedule(_ title: String, for notifications: [HabitNotification]) async {
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
            content.categoryIdentifier = NotificationCategory.category
            
            let request = UNNotificationRequest(
                identifier: notification.identifier,
                content: content,
                trigger: trigger
            )
            print("Notifications: time=\(String(describing: dateComponents.hour)):\(String(describing: dateComponents.minute)) - \(dateComponents)")
            try? await center.add(request)
        }
    }
    
    func later(identifier: String, content: UNNotificationContent, minute: Int) async {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(minute * 60), repeats: false)
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        print("Notifications: \(#function): later: \(minute) min")
        
        try? await center.add(request)
    }
    
    func deactivate(for notifications: [HabitNotification]) async {
        guard !notifications.isEmpty else { return }
        
        let allIDs = notifications.map { $0.identifier }
        center.removePendingNotificationRequests(withIdentifiers: allIDs)
    }
    
    func deleteAll() {
        center.removeAllPendingNotificationRequests()
    }
}
