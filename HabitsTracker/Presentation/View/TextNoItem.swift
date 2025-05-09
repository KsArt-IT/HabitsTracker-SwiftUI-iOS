//
//  TextNoItem.swift
//  HabitsTracker
//
//  Created by KsArT on 09.05.2025.
//

import SwiftUI

struct TextNoItem: View {
    var body: some View {
        Text("No habits")
            .font(Constants.Fonts.normalRegular)
            .foregroundStyle(Color.textGray)
            .padding(.bottom, 100)
    }
}

#Preview {
    TextNoItem()
}
