//
//  MainScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct MainScreen: View {
    @Environment(\.diManager) private var di
    @State private var selectedTab: AppTab = AppTab.day
    @State private var isShowHabitAdd = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Title
            TabTitleView(title: "Hi, \(Profile.user?.name ?? "")") {
                isShowHabitAdd = true
            }
            .padding(.vertical, Constants.Sizes.tiny)

            // Segmented Control
            TabSegmentedView(selection: $selectedTab)
            
            // Content
            TabView(selection: $selectedTab) {
                HabitDayScreen(viewModel: di.resolve())
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
        .fullScreenCover(isPresented: $isShowHabitAdd) {
            
        } content: {
            
        }
    }
}

#Preview {
    MainScreen()
}
