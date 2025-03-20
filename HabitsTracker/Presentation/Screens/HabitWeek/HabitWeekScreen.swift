//
//  HabitWeekScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct HabitWeekScreen: View {
    @StateObject var viewModel: HabitWeekViewModel

    var body: some View {
        VStack{
            TitleTextView("Habit Week")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, Constants.Sizes.small)
    }
}

#Preview {
//    HabitWeekScreen()
}
