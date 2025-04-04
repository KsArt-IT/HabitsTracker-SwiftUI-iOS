//
//  CardTitle.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import SwiftUI

struct CardNameEditView: View {
    @Binding var text: String
    
    var body: some View {
        FormTitleView("Etner Card Name") {
            CustomTextField(hint: "Name", text: $text)
                .padding(.horizontal, Constants.Sizes.medium)
                .padding(.bottom, Constants.Sizes.medium)
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    CardNameEditView(text: $text)
}
