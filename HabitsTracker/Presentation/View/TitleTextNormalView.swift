//
//  TitleTextNornalView.swift
//  HabitsTracker
//
//  Created by KsArT on 01.04.2025.
//

import SwiftUI

struct TitleTextNormalView: View {
    let title: LocalizedStringKey
    
    init(_ title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(Constants.Fonts.normalRegular)
            .foregroundStyle(Color.text)
            .lineLimit(1)
            .truncationMode(.tail)
    }
}

#Preview {
    TitleTextNormalView("")
}
