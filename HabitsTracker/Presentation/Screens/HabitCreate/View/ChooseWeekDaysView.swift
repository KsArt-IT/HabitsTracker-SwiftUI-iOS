//
//  ChooseWeekDaysView.swift
//  HabitsTracker
//
//  Created by KsArT on 03.04.2025.
//

import SwiftUI

struct ChooseWeekDaysView: View {
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let check: (WeekDays) -> Bool
    let change: (WeekDays, Bool) -> Void
    
    var body: some View {
        FormTitleView("Choose a day") {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(WeekDays.allCases) { day in
                    CheckBoxView(title: day.rawValue, checked: check(day)) { checked in
                        change(day, checked)
                    }
                }
            }
            .padding(.horizontal, Constants.Sizes.medium)
        }
    }
}

#Preview {
    ChooseWeekDaysView {_ in
        true
    } change: {_,_  in
        
    }
}
