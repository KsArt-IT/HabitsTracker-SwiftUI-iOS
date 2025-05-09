//
//  HabitActionScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 06.05.2025.
//

import SwiftUI

struct HabitActionScreen: View {
    @MainActor
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: HabitActionViewModel
    let id: UUID
    @Binding var habitMenu: HabitMenu
    
    var body: some View {
        VStack {
            // Navigation back
            NavTitleView {
                close()
            }
            
            if let habit = viewModel.habit {
                ScrollView(showsIndicators: false) {
                    FormTitleAndMenuView(
                        habit.title,
                        edit: {
                            habitMenu = .edit(id: habit.id)
                        },
                        delete: {
                            viewModel.deleteHabit()
                            close()
                        }) {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(habit.intervals) { interval in
                                    CheckBoxView(
                                        label: "\(interval.time.toHoursMinutes()) \(interval.time.toHoursAmPm())",
                                        checked: viewModel.check(interval.id)
                                    ) { _ in
                                        viewModel.change(interval)
                                    }
                                }
                            }
                            .padding(.horizontal, Constants.Sizes.medium)
                            .padding(.bottom, Constants.Sizes.medium)
                        }
                }
                .padding(.top, Constants.Sizes.small)
            } else {
                ZStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .task {
                    if (await viewModel.fetchHabit(by: id)) == nil {
                        close()
                    }
                }
            }
        }
        .padding(.horizontal, Constants.Sizes.medium)
        .padding(.bottom, 1)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private func close() {
        viewModel.reloadHabit()
        dismiss()
    }
}

#Preview {
    //    HabitActionScreen(
    //        viewModel:  HabitActionViewModel(repository: HabitRepositoryImpl(service: DataServiceImpl)),
    //        id: UUID(),
    //        habitMenu: .constant(.none)
    //    )
}
