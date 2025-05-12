//
//  HabitsTrackerApp.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import SwiftUI

@main
struct HabitsTrackerApp: App {
    // создаем diManager и передаем его ниже
    private var di: DIManager

    init() {
        debugPrint(URL.applicationSupportDirectory.path(percentEncoded: false))
        di = DIManager()
        // notification
        let notificationDelegate: NotificationDelegate = di.resolve(NotificationDelegate.self)!
        // category
        UNUserNotificationCenter.current().setNotificationCategories([notificationDelegate.getCategories()])
        // delegate
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.diManager, di)
        }
    }
    
}
