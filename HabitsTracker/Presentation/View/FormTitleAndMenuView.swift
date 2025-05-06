//
//  FormTitleAndMenuView.swift
//  HabitsTracker
//
//  Created by KsArT on 06.05.2025.
//

import SwiftUI

struct FormTitleAndMenuView<Content> : View where Content : View {
    let title: String
    let edit: () -> Void
    let delete: () -> Void
    let content: Content
    
    init(
        _ title: String,
        edit: @escaping () -> Void,
        delete: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.edit = edit
        self.delete = delete
        self.content = content()
    }
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleTextAndMenuView(title: title, edit: edit, delete: delete)
                .padding(.leading, Constants.Sizes.medium)
                .padding(.vertical, Constants.Sizes.small)
            content
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.Sizes.habitCornerRadius)
                .fill(
                    RadialGradient(
                        colors: [.formBackground.opacity(0.75), .formBackground],
                        center: .bottomLeading,
                        startRadius: .zero,
                        endRadius: 250
                    )
                )
        )
    }
}

#Preview {
    FormTitleAndMenuView("", edit: {}, delete: {}) {
        Text("Test")
    }
}
