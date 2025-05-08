//
//  MainScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

enum HabitMenu: Equatable {
    case none
    case edit(id: UUID?)
    case action(id: UUID)
}

struct MainScreen: View {
    @Environment(\.diManager) private var di
    @State private var selectedTab: AppTab = AppTab.day
    @State private var isShowHabitAdd = false
    @State private var habitMenu: HabitMenu = .none
    
    var body: some View {
        VStack(spacing: 0) {
            // Title
            TabTitleView(title: String(localized: "Hi") + ", \(Profile.user?.name ?? "-")") {
                habitMenu = .edit(id: nil)
            }
            .padding(.bottom, Constants.Sizes.medium)
            
            // Segmented Control
            TabSegmentedView(selection: $selectedTab)
            
            // Content
            TabView(selection: $selectedTab) {
                HabitDayScreen(viewModel: di.resolve(), habitMenu: $habitMenu)
                    .tag(AppTab.day)
                    .transition(.slide)
                HabitWeekScreen(viewModel: di.resolve())
                    .tag(AppTab.week)
                    .transition(.slide)
                HabitMonthScreen(viewModel: di.resolve())
                    .tag(AppTab.month)
                    .transition(.slide)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.spring, value: selectedTab)
        }
        .padding(.horizontal, Constants.Sizes.medium)
        .background(Color.brandGray)
        .onChange(of: habitMenu, { _, newValue in
            isShowHabitAdd = newValue != .none
        })
        .fullScreenCover(isPresented: $isShowHabitAdd) {
            habitMenu = .none
        } content: {
            switch habitMenu {
            case .edit(nil): HabitEditScreen(viewModel: di.resolve(), id: nil)
            case .edit(let id): HabitEditScreen(viewModel: di.resolve(), id: id)
            case .action(let id): HabitActionScreen(viewModel: di.resolve(), id: id, habitMenu: $habitMenu)
            case .none: EmptyView()
            }
        }
    }
}

#Preview {
    MainScreen()
}
