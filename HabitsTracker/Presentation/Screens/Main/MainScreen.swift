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

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Segmented Control
                TabSegmentedView(selection: $selectedTab)
                .padding(.horizontal)

                // Content
                TabView(selection: $selectedTab) {
                    HabitDayScreen(viewModel: di.resolve())
                        .tag(AppTab.day)
//                        .transition(.slide)
                    HabitWeekScreen(viewModel: di.resolve())
                        .tag(AppTab.week)
                        .transition(.slide)
                    HabitMonthScreen(viewModel: di.resolve())
                        .tag(AppTab.month)
                        .transition(.slide)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.spring(), value: selectedTab)
            }
            .navigationTitle("Hi, \(Profile.user?.name ?? "")")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    // MainScreen(viewModel: MainViewModel(habitRepository: PreviewHabitRepository()))
}
