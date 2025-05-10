//
//  DataBase.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import SwiftData

final class DataBase {
    private let container: ModelContainer
    let context: ModelContext
    
    init() {
        let schema = Schema([
            UserModel.self,
            HabitModel.self,
            HourIntervalModel.self,
            HourIntervalCompletedModel.self,
            HabitNotificationModel.self,
        ])
        let config = ModelConfiguration(schema: schema)
        
        do {
            self.container = try ModelContainer(for: schema, configurations: [config])
            self.context = ModelContext(self.container)
            self.context.autosaveEnabled = false
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
