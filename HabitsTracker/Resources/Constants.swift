//
//  Constants.swift
//  HabitsTracker
//
//  Created by KsArT on 15.03.2025.
//

import Foundation
import SwiftUICore

enum Constants {
    // app name from Bundle
    static let appName: String = {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "HabitsTracker"
    }()

    enum Sizes {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 44
        
        static let icon: CGFloat = 24
        static let paddingVertical: CGFloat = 12

        static let timeViewHeight: CGFloat = 44
        static let timeViewDivider: CGFloat = 32

        static let textFieldHeight: CGFloat = 44
        static let textFieldPaddingHorizontal: CGFloat = 16
        static let textFieldPaddingVertical: CGFloat = 12
        static let textFieldCornerRadius: CGFloat = 16
        
        static let formCornerRadius: CGFloat = 24
        
        static let buttonHeight: CGFloat = 48
        static let buttonCornerRadius: CGFloat = buttonHeight / 2
        static let buttonDisabledOpacity: CGFloat = 0.64
        
        static let radialGradientStartPercent = 0.3
        static let radialGradientEndPercent = 1.1
        
        static let shadowRadius: CGFloat = 4
        static let shadowOffset: CGFloat = shadowRadius / 2
        
        static let appTabPaddingVertical: CGFloat = 12
        
    }
    
    enum Fonts {
        static let largeTitle = Font.system(size: 48, weight: .semibold)
        
        static let mediumTitle = Font.system(size: 32, weight: .semibold)
        
        static let normalLabel = Font.system(size: 20, weight: .regular)
        
        static let normalRegular = Font.system(size: 16, weight: .regular)
        static let normalMedium = Font.system(size: 16, weight: .medium)
        
        static let captionRegular = Font.system(size: 14, weight: .regular)
        static let captionLight = Font.system(size: 14, weight: .light)
        
        static let appTab = Font.system(size: 14, weight: .medium)
    }
    
    enum Times {
        static let maxCount = 12

        static let appTabAnimation = 0.15
    }
    
    enum Namespace {
        static let appTabGeometryId = "APPTAB.ID"
    }
}
