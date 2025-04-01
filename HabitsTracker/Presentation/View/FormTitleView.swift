//
//  FormTitleView.swift
//  HabitsTracker
//
//  Created by KsArT on 01.04.2025.
//

import SwiftUI

struct FormTitleView<Content> : View where Content : View {
    private let title: LocalizedStringKey
    private let content: Content
    
    init(_ title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content()
    }
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Sizes.medium) {
            TitleTextNormalView(title)
            content
        }
        .padding(Constants.Sizes.medium)
        .formBackground()
    }
}

#Preview {
    FormTitleView("Test") {
        Text("Test 1")
        Text("Test 2")
    }
}
