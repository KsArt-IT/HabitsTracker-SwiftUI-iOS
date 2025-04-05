//
//  AlertModifier.swift
//  HabitsTracker
//
//  Created by KsArT on 05.04.2025.
//

import SwiftUI

struct SheetTimeSelectModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var date: Date
    var action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                FormTitleView("Select Time") {
                    VStack(alignment: .center) {
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: .hourAndMinute
                        )
                        .font(Constants.Fonts.normalRegular)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "en_US_POSIX"))

                        PrimaryButton(label: "Select", disabled: false) {
                            isPresented = false
                            action()
                        }
                        .padding(.top, Constants.Sizes.medium)
                    }
                    .padding(Constants.Sizes.medium)
                }
                .padding(Constants.Sizes.medium)
                .presentationDetents([.medium])
                .presentationBackground(Color.brandGray)
            }
    }
}

extension View {
    func showTimePicker(
        _ isPresented: Binding<Bool>,
        date: Binding<Date>,
        action: @escaping () -> Void = {}
    ) -> some View {
        self.modifier(
            SheetTimeSelectModifier(
                isPresented: isPresented,
                date: date,
                action: action
            )
        )
    }
}
