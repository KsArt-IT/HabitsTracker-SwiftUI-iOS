//
//  MonthSelectorView.swift
//  HabitsTracker
//
//  Created by KsArT on 17.05.2025.
//

import SwiftUI

struct MonthSelectorView: View {
    @Binding var date: Date
    
    var body: some View {
        HStack(spacing: .zero) {
            IconButtonView(name: "arrowLeft", clear: true, disabled: false) {
                withAnimation {
                    date = date.previousMonth()
                }
            }
            Spacer()
            HStack(spacing: .zero) {
            MonthNameView(date: date.previousMonth(), selected: false, disabled: false)
            MonthNameView(date: date, selected: true, disabled: false)
            MonthNameView(date: date.nextMonth(), selected: false, disabled: false)
            }
            .animation(.bouncy(duration: 1), value: date)
            Spacer()
            IconButtonView(name: "arrowRight", clear: true, disabled: false) {
                withAnimation {
                    date = date.nextMonth()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var date = Date.now
    MonthSelectorView(date: $date)
}
