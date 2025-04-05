//
//  FirstScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import SwiftUI

struct HelloScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var inputName: String = ""

    @Binding var name: String

    var body: some View {
        GeometryReader { geometry in
            let start = min(geometry.size.width, geometry.size.height)
            let end = max(geometry.size.width, geometry.size.height)
            
            VStack {
                VStack(alignment: .leading, spacing: Constants.Sizes.small) {
                    Text("Welcome")
                        .font(Constants.Fonts.largeTitle)
                    Text("Please enter your name")
                        .font(Constants.Fonts.normalLabel)
                }
                Spacer()
                VStack {
                    StrokeTextField(
                        hint: "Enter your name",
                        text: $inputName
                    )
                    .padding(.vertical)
                    PrimaryButton(label: "Continue", disabled: inputName.isEmpty) {
                        name = inputName
                        dismiss()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding()
            .radialGradientBackground(
                center: .topLeading,
                startRadius: start,
                endRadius: end
            )
        }
    }
}

#Preview {
//    HelloScreen()
}
