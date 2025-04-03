//
//  PeriodEditView.swift
//  HabitsTracker
//
//  Created by KsArT on 01.04.2025.
//

import SwiftUI

struct PeriodEditView<Content: View>: View {
    @Namespace private var animation
    
    @Binding var selected: Int
    let content: () -> Content
    
    private var periodSelected: PeriodDays {
        if 0..<PeriodDays.allCases.count ~= selected {
            return PeriodDays.allCases[selected]
        } else {
            return .daily
        }
    }
    
    var body: some View {
        FormTitleView("How Often") {
            ForEach(PeriodDays.allCases) { period in
                RadioButton(title: period.rawValue, selected: periodSelected == period) {
                    withAnimation(.spring()) {
                        selected = PeriodDays.allCases.firstIndex(of: period) ?? 0
                    }
                }
            }
            .padding(.horizontal, Constants.Sizes.medium)
            
            if periodSelected == .dayOfWeek {
                content()
                    .transition(.opacity.combined(with: .move(edge: .top))) // Анимация появления
            }
            
            Color.clear
                .frame(height: Constants.Sizes.medium)
        }
        .animation(.spring(), value: selected) // Анимируем изменение `selected`
        .matchedGeometryEffect(id: Constants.Namespace.appTabGeometryId, in: animation)
    }
}

#Preview {
    //        PeriodEditView()
}

enum PeriodDays: LocalizedStringKey, CaseIterable, Identifiable {
    case daily = "Daily"
    case dayOfWeek = "Your own schedule"
    
    var id: Self { self }
}
