//
//  DIEnvironmentKey.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import SwiftUI

struct DIEnvironmentKey: EnvironmentKey {
    static let defaultValue = DIManager()
}

extension EnvironmentValues {
    var diManager: DIManager {
        get { self[DIEnvironmentKey.self] }
        set { self[DIEnvironmentKey.self] = newValue }
    }
}

extension View {
    func environmentDI(_ value: DIManager) -> some View {
        environment(\.diManager, value)
    }
}
