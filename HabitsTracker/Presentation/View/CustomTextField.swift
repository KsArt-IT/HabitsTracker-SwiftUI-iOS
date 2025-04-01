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
            .textContentType(.name)

    }
}

fileprivate struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, Constants.Sizes.textFieldPaddingHorizontal)
            .padding(.vertical, Constants.Sizes.textFieldPaddingVertical)
            .background(
                RoundedRectangle(cornerRadius: Constants.Sizes.textFieldCornerRadius)
                    .fill(.textFieldFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.Sizes.textFieldCornerRadius)
                            .stroke(.stroke, lineWidth: 1)
                    )
            )
            .frame(idealHeight: Constants.Sizes.textFieldHeight)
    }
}

#Preview {
    CustomTextField(hint: "Input Text", text: .constant("Test"))
}
