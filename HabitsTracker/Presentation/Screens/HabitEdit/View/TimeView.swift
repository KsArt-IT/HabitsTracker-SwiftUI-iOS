//
//  TimeView.swift
//  HabitsTracker
//
//  Created by KsArT on 04.04.2025.
//

import SwiftUI

struct TimeView: View {
    let time: Int
    let select: () -> Void
    let toggle: () -> Void
    
    var body: some View {
        HStack {
            Text(time.toHoursMinutes())
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    select()
                }
            
            Divider()
                .frame(height: Constants.Sizes.timeViewDivider)
                .foregroundStyle(Color.devider)
            
            HStack {
                Text(time.toHoursAmPm())
                Image("AmPm")
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                toggle()
            }
        }
        .padding(Constants.Sizes.medium)
        .frame(height: Constants.Sizes.timeViewHeight, alignment: .center)
        .font(Constants.Fonts.captionLight)
        .foregroundStyle(Color.text)
        .background(Color.brandGray)
        .clipShape(RoundedRectangle(cornerRadius: Constants.Sizes.textFieldCornerRadius))
    }
}

#Preview {
    TimeView(time: 720, select: {}, toggle: {})
        .padding()
        .background(Color.formBackground)
}
