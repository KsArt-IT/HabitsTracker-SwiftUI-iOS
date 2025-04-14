//
//  ChooseTimeView.swift
//  HabitsTracker
//
//  Created by KsArT on 04.04.2025.
//

import SwiftUI

struct ChooseTimeView: View {
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var date = Date()
    @State private var dateSelectIndex = 0
    @State private var dateSelectPresented = false
    
    @Binding var times: [Int]
    let actionPositive: () -> Void
    let actionNegative: () -> Void
    
    var body: some View {
        FormTitleView("Choose a time") {
            LazyVGrid(columns: columns, spacing: Constants.Sizes.spacingTime) {
                ForEach(times.indices, id: \.self) { index in
                    TimeView(time: times[index]) {
                        date = times[index].toDateFromMinutes()
                        dateSelectIndex = index
                        dateSelectPresented = true
                    } toggle: {
                        times[index] = times[index].toggleAmPm()
                    }
                }
            }
            .padding(.horizontal, Constants.Sizes.medium)
            
            HStack(spacing: Constants.Sizes.medium) {
                OutlinedButton(label: "Delete", color: .outlineDelete, disabled: times.count < 2, action: actionNegative)
                OutlinedButton(label: "Add Time", color: .text, disabled: times.count >= Constants.Times.maxCount, action: actionPositive)
            }
            .padding(Constants.Sizes.medium)
        }
        .showTimePicker($dateSelectPresented, date: $date) {
            if 0..<times.count ~= dateSelectIndex {
                times[dateSelectIndex] = date.toMinutesFromDate()
                dateSelectIndex = 0
            }
        }
    }
}

#Preview {
    //    ChooseTimeView(times: )
}
