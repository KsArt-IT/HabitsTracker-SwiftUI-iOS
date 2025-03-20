//
//  OnboardScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 14.03.2025.
//

import SwiftUI

struct OnboardScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var isHelloVisible = false
    
    @Binding var name: String
    
    var body: some View {
        GeometryReader { geometry in
            let size = max(geometry.size.width, geometry.size.height)
            
            VStack {
                VStack {
                    Image(.onboardLogo)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                VStack {
                    Image(.hello)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    PrimaryButton(label: "Continue", disabled: false) {
                        isHelloVisible = true
                    }
                }
            }
            .padding()
            .radialGradientBackground(
                center: .topLeading,
                startRadius: size * Constants.Sizes.radialGradientStartPercent,
                endRadius: size * Constants.Sizes.radialGradientEndPercent
            )
        }
        .fullScreenCover(isPresented: $isHelloVisible) {
            dismiss()
        } content: {
            HelloScreen(name: $name)
        }

    }
}

#Preview {
    @Previewable @State var name = ""
    OnboardScreen(name: $name)
}
