//
//  MonthNameView.swift
//  HabitsTracker
//
//  Created by KsArT on 17.05.2025.
//

import SwiftUI

struct MonthNameView: View {
    let date: Date
    let selected: Bool
    let disabled: Bool
    
    var body: some View {
        Text(disabled ? "": date.toMonthShort())
            .font(Constants.Fonts.accentMedium)
            .foregroundStyle(selected ? Color.text : Color.textGray)
            .frame(width: Constants.Sizes.selectorWidth)
            .lineLimit(1)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    MonthNameView(date: Date.now, selected: true, disabled: false)
}
