//
//  HabitMonthScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitMonthScreen: View {
    @StateObject var viewModel: HabitMonthViewModel

    var body: some View {
        VStack{
            TitleTextView("Habit Month")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, Constants.Sizes.small)
    }
}

#Preview {
//    HabitMonthScreen()
}
