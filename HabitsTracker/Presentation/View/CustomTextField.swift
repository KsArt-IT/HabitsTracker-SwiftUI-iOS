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
        TextField(
            "",
            text: $text,
            prompt: Text(hint)
                .font(Constants.Fonts.captionLight)
                .foregroundColor(.textFieldHint)
        )
        .font(Constants.Fonts.normalRegular)
        .foregroundStyle(.textField)
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
                    .fill(.textFieldBackground)
            )
            .frame(idealHeight: Constants.Sizes.textFieldHeight)
    }
}

#Preview {
    CustomTextField(hint: "Input Text", text: .constant("Test"))
}
