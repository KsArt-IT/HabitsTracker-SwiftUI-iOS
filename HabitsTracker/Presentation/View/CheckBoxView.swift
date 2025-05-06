//
//  CheckBoxView.swift
//  HabitsTracker
//
//  Created by KsArT on 03.04.2025.
//

import SwiftUI

struct CheckBoxView: View {
    private let title: String
    @State private var checked: Bool
    private let action: (Bool) -> Void
    
    init(title: LocalizedStringResource? = nil, label: String = "", checked: Bool, action: @escaping (Bool) -> Void) {
        self.title = if let title { String(localized: title) } else { label }
        self.checked = checked
        self.action = action
    }
    
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
