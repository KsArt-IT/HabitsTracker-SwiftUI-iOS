//
//  DayMonthView.swift
//  HabitsTracker
//
//  Created by KsArT on 06.06.2025.
//


import SwiftUI

struct WeekItemView: View {
    let date: Date
    let selected: Bool
    let disabled: Bool
    
    var body: some View {
        Text(disabled ? "": "\(date.weekOfYear)")
            .font(selected ? Constants.Fonts.accentMedium : Constants.Fonts.normalLabel)
            .foregroundStyle(selected ? Color.text : Color.textGray)
            .frame(width: Constants.Sizes.selectorWidth)
            .lineLimit(1)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    WeekItemView(date: Date.now, selected: true, disabled: false)
}
