//
//  HabitFlowScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitFlowScreen: View {
    @StateObject var viewModel: HabitFlowViewModel

    var body: some View {
        VStack{
            TitleTextView("Habit Flow")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, Constants.Sizes.small)
    }
}

#Preview {
//    HabitFlowScreen()
}
