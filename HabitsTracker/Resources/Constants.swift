//
//  Constants.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import Foundation
import SwiftUICore

enum Constants {
    enum Sizes {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        
        static let textFieldPaddingHorizontal: CGFloat = 16
        static let textFieldPaddingVertical: CGFloat = 12
        static let textFieldCornerRadius: CGFloat = 24
        
        static let bottomHeight: CGFloat = 54
        static let bottomCornerRadius: CGFloat = bottomHeight / 2
        
        static let radialGradientStartPercent = 0.7
        static let radialGradientEndPercent = 1.1
    }
    
    enum Fonts {
        static let largeTitle = Font.system(size: 48, weight: .semibold)
        
        static let normalLabel = Font.system(size: 20, weight: .regular)
        
        static let normalRegular = Font.system(size: 16, weight: .regular)
        
        static let captionRegular = Font.system(size: 14, weight: .regular)
        static let captionLight = Font.system(size: 14, weight: .light)
    }
}
