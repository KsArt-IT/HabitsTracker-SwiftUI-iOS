//
//  CardTitle.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct CardTitleView: View {
    @Binding var title: String
    
    var body: some View {
        VStack {
            Text("Etner Card Name")
            CustomTextField(
                hint: "Name",
                text: $title
            )
            .padding(.vertical, Constants.Sizes.medium)
        }
    }
}

#Preview {
    @Previewable @State var title = ""
    CardTitleView(title: $title)
}
