//
//  ReminderToggleView.swift
//  HabitsTracker
//
//  Created by KsArT on 04.04.2025.
//

import SwiftUI

struct ReminderToggleView: View {
    @Binding var enabled: Bool
    
    var body: some View {
        FormTitleView("Reminder") {
            VStack {
                RadioButton(title: "Without Reminder", selected: !enabled)
                    .onTapGesture {
                        withAnimation {
                            enabled = false
                        }
                    }
                RadioButton(title: "Enable Reminders", selected: enabled)
                    .onTapGesture {
                        withAnimation {
                            enabled = true
                        }
                    }
            }
            .padding(.horizontal, Constants.Sizes.medium)
            .padding(.bottom, Constants.Sizes.medium)
        }
    }
}

#Preview {
    @Previewable @State var enabled = false
    ReminderToggleView(enabled: $enabled)
}
