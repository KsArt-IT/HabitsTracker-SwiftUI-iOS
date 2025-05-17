//
//  MonthSelectorView.swift
//  HabitsTracker
//
//  Created by KsArT on 17.05.2025.
//

import SwiftUI

struct MonthSelectorView: View {
    let date: Date
    let previousMonth: () -> Void
    let nextMonth: () -> Void
    
    private var isFirst: Bool {
        date.month() == 1
    }
    private var isLast: Bool {
        date.month() == 12
    }
    
    var body: some View {
        HStack(spacing: Constants.Sizes.medium) {
            IconButtonView(
                systemName: "chevron.backward",
                clear: true,
                disabled: isFirst,
                action: previousMonth,
            )
            Spacer()
            MonthNameView(date: date.previousMonth(), selected: false, disabled: isFirst)
            MonthNameView(date: date, selected: true, disabled: false)
            MonthNameView(date: date.nextMonth(), selected: false, disabled: isLast)
            Spacer()
            IconButtonView(
                systemName: "chevron.forward",
                clear: true,
                disabled: isLast,
                action: nextMonth,
            )
        }
    }
}

#Preview {
    @Previewable @State var date = Date.now
    MonthSelectorView(
        date: date,
        previousMonth: { date = date.previousMonth() },
        nextMonth: { date = date.nextMonth() },
    )
}
