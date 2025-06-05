//
//  DaySelectorView.swift
//  HabitsTracker
//
//  Created by KsArT on 17.05.2025.
//

import SwiftUI

struct DaySelectorView: View {
    @Binding var date: Date
    
    var body: some View {
        HStack(spacing: .zero) {
            IconButtonView(name: "arrowLeft", clear: true, disabled: false) {
                withAnimation(.linear(duration: 1)) {
                    date = date.previousDay()
                }
            }
            Spacer()
            HStack(spacing: .zero) {
                DayMonthView(date: date.previousDay(), selected: false, disabled: false)
                DayMonthView(date: date, selected: true, disabled: false)
                DayMonthView(date: date.nextDay(), selected: false, disabled: false)
            }
            .animation(.linear, value: date)
            Spacer()
            IconButtonView(name: "arrowRight", clear: true, disabled: false) {
                withAnimation(.linear(duration: 1)) {
                    date = date.nextDay()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var date = Date.now
    DaySelectorView(date: $date)
}
