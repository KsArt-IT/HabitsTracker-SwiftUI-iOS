//
//  RadioButton.swift
//  HabitsTracker
//
//  Created by KsArT on 01.04.2025.
//

import SwiftUI

struct RadioButton: View {
    let title: LocalizedStringKey
    let selected: Bool
    
    var body: some View {
        HStack {
            Image(selected ? "RadioButtonSelected" : "RadioButton")
                .resizable()
                .frame(width: Constants.Sizes.icon, height: Constants.Sizes.icon)
            
            Text(title)
                .font(Constants.Fonts.captionRegular)
            
            Spacer()
        }
        .foregroundColor(selected ? .textRadioSelected : .textRadio)
        .padding(Constants.Sizes.small)
        .contentShape(Rectangle())
    }
}
