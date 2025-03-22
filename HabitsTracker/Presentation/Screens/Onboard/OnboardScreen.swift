//
//  OnboardScreen.swift
//  HabitsTracker
//
//  Created by KsArT on 14.03.2025.
//

import SwiftUI

struct OnboardScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isHelloVisible = false
    
    @StateObject var viewModel: OnboardViewModel
    @Binding var name: String
    @Binding var initialized: Bool
    
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
                    if viewModel.needName {
                        PrimaryButton(label: "Continue", disabled: false) {
                            isHelloVisible = true
                        }
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
        .task(id: name) {
            debugPrint("OnboardScreen task name=\(name)")
            viewModel.initialize(name: name)
        }
        .onChange(of: viewModel.initialized) { _, newValue in
            debugPrint("OnboardScreen dissmis")
                initialized = true
                dismiss()
        }
        .fullScreenCover(isPresented: $isHelloVisible) {
            HelloScreen(name: $name)
        }
        
    }
}

#Preview {
    //    @Previewable @State var name = ""
    //    OnboardScreen(name: $name)
}
