//
//  HabitCreateScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct HabitCreateScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: HabitCreateViewModel

    var body: some View {
        ScrollView {
            VStack {
                NavTitleView {
                    dismiss()
                }
                CardTitleView(title: $viewModel.cardTitle)
            }
        }
        .padding(.horizontal, Constants.Sizes.medium)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
//    HabitCreateScreen()
}
