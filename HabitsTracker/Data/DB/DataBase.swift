//
//  DataBase.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import SwiftData

final class DataBase {
    private var container: ModelContainer = {
        let schema = Schema([
            UserModel.self,
            HabitModel.self,
            HourIntervalModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    lazy var context: ModelContext = {
        let context = ModelContext(self.container)
        context.autosaveEnabled = false
        return context
    }()
}
