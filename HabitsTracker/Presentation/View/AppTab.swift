//
//  Tab.swift
//  HabitsTracker
//
//  Created by KsArT on 21.03.2025.
//

import SwiftUI

enum AppTab: LocalizedStringKey, Identifiable, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"

    var id : Self {
        self
    }
}
