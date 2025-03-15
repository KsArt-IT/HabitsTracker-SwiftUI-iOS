//
//  CustomTextField.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import SwiftUI

struct CustomTextField: View {
    let hint: LocalizedStringKey
    @Binding var text: String
    
    var body: some View {
        TextField(hint, text: $text)
            .font(Constants.Fonts.normalRegular)
            .textFieldStyle(CustomTextFieldStyle())
    }
}

fileprivate struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, Constants.Sizes.textFieldPaddingHorizontal)
            .padding(.vertical, Constants.Sizes.textFieldPaddingVertical)
            .background(
                RoundedRectangle(cornerRadius: Constants.Sizes.bottomCornerRadius)
                    .fill(.textFieldFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.Sizes.bottomCornerRadius)
                            .stroke(.stroke, lineWidth: 1)
                    )
            )
    }
}

#Preview {
    CustomTextField(hint: "Input Text", text: .constant("Test"))
}
