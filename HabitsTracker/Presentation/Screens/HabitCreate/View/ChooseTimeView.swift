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
    @Binding var times: [Int]
    let actionPositive: () -> Void
    let actionNegative: () -> Void
    
    var body: some View {
        FormTitleView("Choose a time") {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(times.indices, id: \.self) { index in
                    TimeView(time: times[index])
                }
            }
            .padding(.horizontal, Constants.Sizes.medium)
            
            HStack(spacing: Constants.Sizes.medium) {
                OutlinedButton(label: "Delete", color: .outlineDelete, disabled: times.count < 2, action: actionNegative)
                OutlinedButton(label: "Add Time", color: .text, disabled: times.count >= Constants.Times.maxCount, action: actionPositive)
            }
            .padding(Constants.Sizes.medium)
        }
    }
}

#Preview {
    //    ChooseTimeView(times: )
}
