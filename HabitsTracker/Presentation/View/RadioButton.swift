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
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(selected ? "RadioButtonSelected" : "RadioButton")
                .resizable()
                .frame(width: Constants.Sizes.icon, height: Constants.Sizes.icon)
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(Constants.Sizes.small)
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
