//
//  HabitMonthScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitMonthScreen: View {
    @StateObject var viewModel: HabitMonthViewModel
    @Binding var habitMenu: HabitMenu
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.habitStatus.isEmpty {
                TextNoItem()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: Constants.Sizes.medium) {
                        ForEach(viewModel.habitStatus) { status in
                            HabitMonthItemView(status: status) {
                                habitMenu = .edit(id: status.id)
                            } delete: {
                                viewModel.deleteHabit(by: status.id)
                            }
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchHabits()
                }
            }
        }
        .padding(.top, Constants.Sizes.medium)
    }
}

#Preview {
//    HabitMonthScreen()
}
