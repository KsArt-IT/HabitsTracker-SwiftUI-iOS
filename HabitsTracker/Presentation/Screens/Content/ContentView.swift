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
    
    @Environment(\.diManager) private var di
    
    @State private var initialized = false
    
    var body: some View {
        if initialized {
//            MainScreen(viewModel: di.resolve())
        } else {
            FirstScreen()
//            OnboardScreen()
//                .preferredColorScheme(appTheme.scheme(colorScheme))
        }
    }
}

#Preview {
//    ContentView()
}
