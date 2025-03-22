//
//  HabitDayScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitDayScreen: View {
    @StateObject var viewModel: HabitDayViewModel

    var body: some View {
        VStack{
            TitleTextView("Habit Day")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, Constants.Sizes.small)
    }
}

#Preview {
//    HabitDayScreen()
}
