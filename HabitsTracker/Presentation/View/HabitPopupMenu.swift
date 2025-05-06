//
//  HabitPopupMenu.swift
//  HabitsTracker
//
//  Created by KsArT on 06.05.2025.
//

import SwiftUI

struct HabitPopupMenu: View {
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        Menu {
            Button {
                onEdit()
            } label: {
                Label("Edit", systemImage: "square.and.pencil")
            }
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .padding(4)
                .frame(width: Constants.Sizes.icon, height: Constants.Sizes.icon)
                .padding(Constants.Sizes.habitIconPadding)
                .foregroundStyle(.brandBlack)
        }
    }
}

#Preview {
    HabitPopupMenu(onEdit: {}, onDelete: {})
}
