//
//  MainScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct MainScreen: View {
    @Environment(\.diManager) private var di
    @State private var selectedTab: Tab = .flow
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HabitFlowScreen(viewModel: di.resolve())
                .tabMenu(Tab.flow)
            HabitWeekScreen(viewModel: di.resolve())
                .tabMenu(Tab.week)
            HabitMonthScreen(viewModel: di.resolve())
                .tabMenu(Tab.month)
            SettingsScreen(viewModel: di.resolve())
                .tabMenu(Tab.settings)
        }
        // Hiding Tab Bar When Aheet is Expanded
        .toolbar(.visible, for: .tabBar)
    }
}

extension View {
    @ViewBuilder
    fileprivate func tabMenu(_ tab: Tab) -> some View {
        self
            .tag(tab)
            .tabItem {
                Label {
                    Text(tab.rawValue)
                } icon: {
                    Image(systemName: tab.icon)
                }
            }
            // изменить цвет TabView, необходимо для каждого, поэтому расположено тут
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThickMaterial, for: .tabBar)
    }
}

private enum Tab: LocalizedStringKey, CaseIterable {
    case flow = "Flow"
    case week = "Week"
    case month = "Month"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .flow:
            "flag.badge.ellipsis"
        case .week:
            "ellipsis.bubble"
        case .month:
            "tablecells.badge.ellipsis"
        case .settings:
            "gearshape"
        }
    }
}

#Preview {
    //    MainScreen()
}
