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
    // создаем diManager и передаем его ниже
    @Environment(\.diManager) private var di
    // для проверки имени
    @State private var initialized = false
    
    var body: some View {
        if initialized {
            MainScreen()
                .environment(\.diManager, di)
        } else {
            OnboardScreen(viewModel: di.resolve(), name: $userName, initialized: $initialized)
//                .preferredColorScheme(appTheme.scheme(colorScheme))
        }
    }
}

#Preview {
    ContentView()
}
