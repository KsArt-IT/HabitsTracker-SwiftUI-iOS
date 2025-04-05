//
//  CheckBoxView.swift
//  HabitsTracker
//
//  Created by KsArT on 03.04.2025.
//

import SwiftUI

struct CheckBoxView: View {
    let title: LocalizedStringKey
    @State var checked: Bool
    let action: (Bool) -> Void
    
    var body: some View {
        HStack {
            Image(checked ? "CheckBoxChecked" : "CheckBox")
                .resizable()
                .frame(width: Constants.Sizes.icon, height: Constants.Sizes.icon)
            
            Text(title)
                .font(Constants.Fonts.captionRegular)

            Spacer()
        }
        .foregroundColor(checked ? .textRadioSelected : .textRadio)
        .padding(Constants.Sizes.small)
        .contentShape(Rectangle())
        .onTapGesture {
            checked.toggle()
            action(checked)
        }
    }
}
