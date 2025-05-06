//
//  TitleAndMenuView.swift
//  HabitsTracker
//
//  Created by KsArT on 06.05.2025.
//

import SwiftUI

struct TitleTextAndMenuView: View {
    let title: String
    let edit: () -> Void
    let delete: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(Constants.Fonts.normalRegular)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundStyle(Color.text)
            Spacer(minLength: Constants.Sizes.small)
            HabitPopupMenu(onEdit: edit, onDelete: delete)
        }
    }
}

#Preview {
    TitleTextAndMenuView(title: "Test", edit: {}, delete: {})
}
