//
//  ContentView.swift
//  HabitsTracker
//
//  Created by KsArT on 13.03.2025.
//

import SwiftUI

struct ContentView: View {
    // получим тему на устройстве
    @Environment(\.colorScheme) private var colorScheme
    // сохраним-загрузим выбранную тему
    @AppStorage("appTheme") private var appTheme = AppTheme.device
    // user name
    @AppStorage("userName") private var userName = ""
    
    @Environment(\.diManager) private var di
    
    var body: some View {
        if userName.isEmpty {
            OnboardScreen(name: $userName)
                .preferredColorScheme(appTheme.scheme(colorScheme))
        } else {
            MainScreen(viewModel: di.resolve())
                .environment(\.diManager, di)
        }
    }
}

#Preview {
    //    ContentView()
}
