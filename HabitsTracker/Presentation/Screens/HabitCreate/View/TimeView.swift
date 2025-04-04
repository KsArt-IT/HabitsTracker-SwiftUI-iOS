//
//  TimeView.swift
//  HabitsTracker
//
//  Created by KsArT on 04.04.2025.
//

import SwiftUI

struct TimeView: View {
    let time: Int
    
    var body: some View {
        HStack {
            Text(time.toHoursMinutes())
                .frame(maxWidth: .infinity)
            
            Divider()
                .foregroundStyle(Color.devider)
            
            Text(time.toHoursAmPm())
                .frame(maxWidth: .infinity)
        }
        .padding(Constants.Sizes.medium)
        .frame(height: Constants.Sizes.textFieldHeight, alignment: .center)
        .font(Constants.Fonts.captionLight)
        .foregroundStyle(Color.text)
        .background(Color.brandGray)
        .clipShape(Capsule())
    }
}

#Preview {
    TimeView(time: 720)
        .padding()
        .background(Color.formBackground)
}

fileprivate extension Int {
    func toHoursMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        var hourIn12 = hours % 12
        hourIn12 = hourIn12 == 0 ? 12 : hourIn12 // 0 часов — это 12 AM или 12 PM
        
        return String(format: "%02d:%02d", hourIn12, minutes)
    }
    
    func toHoursAmPm() -> String {
        self / 60 < 12 ? "am" : "pm"
    }
}
