//
//  NotificationCategory.swift
//  HabitsTracker
//
//  Created by KsArT on 13.05.2025.
//

import Foundation
import UserNotifications

enum NotificationCategory {
    static let category = "HABIT_CATEGORY"
    static let completedAction = "HABIT_COMPLETE_ACTION"
    static let laterAction = "HABIT_REMIND_LATER_ACTION"
    
    static var categories: Set<UNNotificationCategory> {
        print("NotificationDelegate: \(#function)")
        let completeAction = UNNotificationAction(
            identifier: Self.completedAction,
            title: "Mark as done",
            options: [] //[.authenticationRequired]
        )
        
        let remindLaterAction = UNNotificationAction(
            identifier: Self.laterAction,
            title: "Remind me later",
            options: []
        )
        
        return [
            UNNotificationCategory(
                identifier: Self.category,
                actions: [completeAction, remindLaterAction],
                intentIdentifiers: [],
                options: []
            ),
        ]
    }
    
}
