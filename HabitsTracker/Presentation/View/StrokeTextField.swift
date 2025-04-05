//
//  StrokeTextField.swift
//  HabitsTracker
//
//  Created by KsArT on 04.04.2025.
//

import SwiftUI

struct StrokeTextField: View {
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
        .textFieldStyle(StrokeTextFieldStyle())
        .textContentType(.name)
    }
}

fileprivate struct StrokeTextFieldStyle: TextFieldStyle {
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
