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
        
        static let icon: CGFloat = 20
        
        static let textFieldPaddingHorizontal: CGFloat = 16
        static let textFieldPaddingVertical: CGFloat = 12
        static let textFieldCornerRadius: CGFloat = 24
        
        static let bottomHeight: CGFloat = 54
        static let bottomCornerRadius: CGFloat = bottomHeight / 2
        
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
        
        static let captionRegular = Font.system(size: 14, weight: .regular)
        static let captionLight = Font.system(size: 14, weight: .light)
        
        static let appTab = Font.system(size: 14, weight: .medium)
    }
    
    enum Times {
        static let appTabAnimation = 0.15
    }
    
    enum Namespace {
        static let appTabGeometryId = "APPTAB.ID"
    }
}
