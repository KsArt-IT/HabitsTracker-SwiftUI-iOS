//
//  SettingsScreen.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct SettingsScreen: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        VStack{
            TitleTextView("Settings")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, Constants.Sizes.small)
    }
}

#Preview {
//    SettingsScreen()
}
