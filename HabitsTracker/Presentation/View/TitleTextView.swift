//
//  TitleTextView.swift
//  HabitCurrent-SUI
//
//  Created by KsArT on 11.03.2025.
//

import SwiftUI

struct TitleTextView: View {
    @State private var show = false
    private let text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .shadow(radius: Constants.Sizes.shadowRadius, x: Constants.Sizes.shadowOffset, y: Constants.Sizes.shadowOffset)
            .padding(.bottom, Constants.Sizes.small)
            .opacity(show ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 2), value: show)
            .onAppear {
                withAnimation {
                    show = true
                }
            }
    }
}

#Preview {
    TitleTextView("Title test")
}
