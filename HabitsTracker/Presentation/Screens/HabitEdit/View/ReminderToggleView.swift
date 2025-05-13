//
//  ReminderToggleView.swift
//  HabitsTracker
//
//  Created by KsArT on 04.04.2025.
//

import SwiftUI

struct ReminderToggleView: View {
    @Binding var reminder: Bool
    let granted: Bool
    let label: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        FormTitleView("Reminder") {
            VStack {
                if granted {
                    RadioButton(title: "Without Reminder", selected: !reminder)
                        .onTapGesture {
                            withAnimation {
                                reminder = false
                            }
                        }
                    RadioButton(title: "Enable Reminders", selected: reminder)
                        .onTapGesture {
                            withAnimation {
                                reminder = true
                            }
                        }
                } else {
                    PrimaryButton(label: label, disabled: false, action: action)
                }
            }
            .padding(.horizontal, Constants.Sizes.medium)
            .padding(.bottom, Constants.Sizes.medium)
        }
    }
}

#Preview {
    @Previewable @State var reminder = false
    ReminderToggleView(reminder: $reminder, granted: true, label: "") {}
}
