//
//  DaySelectorView.swift
//  HabitsTracker
//
//  Created by KsArT on 06.06.2025.
//


import SwiftUI

struct WeekSelectorView: View {
    @Binding var date: Date
    
    var body: some View {
        HStack(spacing: .zero) {
            IconButtonView(name: "arrowLeft", clear: true, disabled: false) {
                withAnimation {
                    date = date.previousWeek()
                }
            }
            Spacer()
            HStack(spacing: .zero) {
                WeekItemView(date: date.previousWeek(), selected: false, disabled: false)
                WeekItemView(date: date, selected: true, disabled: false)
                WeekItemView(date: date.nextWeek(), selected: false, disabled: false)
            }
            .animation(.bouncy(duration: 1), value: date)
            Spacer()
            IconButtonView(name: "arrowRight", clear: true, disabled: false) {
                withAnimation {
                    date = date.nextWeek()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var date = Date.now
    WeekSelectorView(date: $date)
}
