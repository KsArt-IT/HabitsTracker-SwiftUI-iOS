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
    @Environment(\.diManager) private var di

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.diManager, di)
        }
    }
    
    init() {
        debugPrint(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
}
