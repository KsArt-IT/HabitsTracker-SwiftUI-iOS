//
//  HabitStatusView.swift
//  HabitsTracker
//
//  Created by KsArT on 08.05.2025.
//

import SwiftUI

struct HabitStatusView: View {
    let weekStatus: [HabitDayStatus]
    
    var body: some View {
        HStack(spacing: Constants.Sizes.small) {
            ForEach(weekStatus.indices, id: \.self) { index in
                buildCircle(for: weekStatus[index])
                    .frame(width: Constants.Sizes.habitCircle, height: Constants.Sizes.habitCircle)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    @ViewBuilder
    private func buildCircle(for status: HabitDayStatus) -> some View {
        switch status {
        case .completed:
            Circle()
                .fill(Color.completed)
            
        case .partiallyCompleted:
            Circle()
                .fill(Color.notCompleted)
            
        case .notCompleted:
            Circle()
                .fill(Color.notCompleted)
            
        case .awaitsExecution:
            Circle()
                .stroke(Color.completed.opacity(0.4), lineWidth: 2)
            
        case .skipped:
            Circle()
                .fill(Color.clear)
        
        case .notStarted:
            Circle()
                .fill(Color.clear)
    
        case .closed:
            Circle()
                .fill(Color.clear)
        }
    }
}
