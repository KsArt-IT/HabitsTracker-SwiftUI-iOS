//
//  WeekDaysView.swift
//  HabitsTracker
//
//  Created by KsArT on 08.05.2025.
//

import SwiftUI

struct WeekDaysView: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(CalendarExt.weekDaysShort, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
        .font(Constants.Fonts.captionRegular)
        .foregroundStyle(Color.textWeek)
    }
}

#Preview {
    WeekDaysView()
}
