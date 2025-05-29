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

    private let isFirst: Bool
    private let isLast: Bool
    
    init(date: Date, previousMonth: @escaping () -> Void, nextMonth: @escaping () -> Void) {
        self.date = date
        self.previousMonth = previousMonth
        self.nextMonth = nextMonth
        
        let month = date.month()
        self.isFirst = month == 1
        self.isLast = month == 12
    }
    
    var body: some View {
        HStack(spacing: Constants.Sizes.medium) {
            IconButtonView(
                name: "arrowLeft",
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
                name: "arrowRight",
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
