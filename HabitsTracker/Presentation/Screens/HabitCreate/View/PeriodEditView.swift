//
//  PeriodEditView.swift
//  HabitsTracker
//
//  Created by KsArT on 01.04.2025.
//

import SwiftUI

struct PeriodEditView<Content: View>: View {
    @Binding var selected: Int
    let content: () -> Content
    
    private var periodSelected: PeriodDays {
        if 0..<PeriodDays.allCases.count ~= selected {
            PeriodDays.allCases[selected]
        } else {
            .daily
        }
    }
    
    var body: some View {
        FormTitleView("How Often") {
            ForEach(PeriodDays.allCases) { period in
                RadioButton(title: period.rawValue, selected: periodSelected == period)
                    .onTapGesture {
                        withAnimation {
                            selected = PeriodDays.allCases.firstIndex(of: period) ?? 0
                        }
                    }
            }
            .padding(.horizontal, Constants.Sizes.medium)
            
            if periodSelected == .dayOfWeek {
                content()
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            Color.clear
                .frame(height: Constants.Sizes.medium)
        }
    }
}

#Preview {
    @Previewable @State var selected: Int = 0
    PeriodEditView(selected: $selected) {
        EmptyView()
    }
}

fileprivate enum PeriodDays: LocalizedStringKey, CaseIterable, Identifiable {
    case daily = "Daily"
    case dayOfWeek = "Your own schedule"
    
    var id: Self { self }
}
