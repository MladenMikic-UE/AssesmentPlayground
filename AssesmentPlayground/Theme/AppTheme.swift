//
//  AppTheme.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

public enum AppTheme: String, CaseIterable {
    
    case assesmentPlayground
    case movemedical
    case endava
    
    /// Localized theme description.
    var description: String {
        
        switch self {
        case .assesmentPlayground:
            ""
        case .movemedical:
            ""
        case .endava:
            ""
        }
    }
    
    /// Theme name based on company name.
    var name: String {
        
        switch self {
        case .assesmentPlayground:
            "assesmentPlayground"
        case .movemedical:
            "Movemedical"
        case .endava:
            "Endava"
        }
    }
    
    static var bundleTheme: AppTheme {
        if Bundle.movemedical != nil {
            return .movemedical
        } else if Bundle.endava != nil {
            return .endava
        } else if Bundle.assesmentPlayground != nil {
            return .assesmentPlayground
        } else {
            return .assesmentPlayground
        }
    }
}

// MARK: - Fonts.
extension AppTheme {
    
    var bigFont: Font {
        
        switch self {
        case .assesmentPlayground:
            Font.custom("Helvetica", size: 24)
        case .movemedical:
            Font.custom("Futura", size: 24)
        case .endava:
            Font.custom("Verdana", size: 24)
        }
    }
    
    var tinyFont: Font {
        
        switch self {
        case .assesmentPlayground:
            Font.custom("Helvetica", size: 12)
        case .movemedical:
            Font.custom("Futura", size: 12)
        case .endava:
            Font.custom("Verdana", size: 12)
        }
    }
    
    var miniFont: Font {
        
        switch self {
        case .assesmentPlayground:
            Font.custom("Helvetica", size: 14)
        case .movemedical:
            Font.custom("Futura", size: 14)
        case .endava:
            Font.custom("Verdana", size: 14)
        }
    }
    
    var smallFont: Font {
        
        switch self {
        case .assesmentPlayground:
            Font.custom("Helvetica", size: 16)
        case .movemedical:
            Font.custom("Futura", size: 16)
        case .endava:
            Font.custom("Verdana", size: 16)
        }
    }
    
    var font: Font {
        
        switch self {
        case .assesmentPlayground:
            Font.custom("Helvetica", size: 20)
        case .movemedical:
            Font.custom("Futura", size: 20)
        case .endava:
            Font.custom("Verdana", size: 20)
        }
    }
    
    var smallUIFont: UIFont {
        
        switch self {
        case .assesmentPlayground:
            UIFont(name: "Helvetica", size: 16) ?? .systemFont(ofSize: 16)
        case .movemedical:
            UIFont(name: "Futura", size: 16) ?? .systemFont(ofSize: 16)
        case .endava:
            UIFont(name: "Verdana", size: 16) ?? .systemFont(ofSize: 16)
        }
    }
    
    var uiFont: UIFont {
        
        switch self {
        case .assesmentPlayground:
            UIFont(name: "Helvetica", size: 20) ?? .systemFont(ofSize: 20)
        case .movemedical:
            UIFont(name: "Futura", size: 20) ?? .systemFont(ofSize: 20)
        case .endava:
            UIFont(name: "Verdana", size: 20) ?? .systemFont(ofSize: 20)
        }
    }
}

// MARK: - Colors.
extension AppTheme {
    
    var selectionColor: Color {
        Asset.primarySelectionThemeLabelColor.swiftUIColor
    }
    
    var selectionUIColor: UIColor {
        Asset.primarySelectionThemeLabelColor.color
    }
    
    var backgroundColor: Color {
        Asset.themeBackgroundColor.swiftUIColor
    }
    
    var fontUIColor: UIColor {
        Asset.primayThemeLabelColor.color
    }
    
    var fontColor: Color {
        Asset.primayThemeLabelColor.swiftUIColor
    }
    
    var shadowColor: Color {
        primaryFontColor.opacity(0.45)
    }
    
    var regularButtonShadowMetadata: ShadowViewMetadata {
        ShadowViewMetadata(radius: 2, x: 1, y: 1)
    }
    
    var bigButtonShadowMetadata: ShadowViewMetadata {
        ShadowViewMetadata(radius: 4, x: 2, y: 4)
    }

    var primaryFontColor: Color {
        Asset.primayThemeLabelColor.swiftUIColor
    }
}

struct ShadowViewMetadata {
    
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    init(radius: CGFloat = 0,
         x: CGFloat = 0,
         y: CGFloat = 0) {
        self.radius = radius
        self.x = x
        self.y = y
    }
}

// MARK: - Gradient.
extension AppTheme {
    
    var animatedGradientRange: AnimatedGradient {
        AnimatedGradient(gradient, reversedGradient)
    }
    
    var gradient: Gradient {
        
        switch self {
        case .assesmentPlayground:
            .defaultWhite()
        case .movemedical:
            .defaultMovemedical()
        case .endava:
            .defaultEndava()
        }
    }
    
    var bottomHeavyGradient: Gradient {
        
        switch self {
        case .assesmentPlayground:
            .defaultWhite()
        case .movemedical:
            .defaultMovemedical()
        case .endava:
            .bottomHeavyEndava()
        }
    }
    
    var reversedGradient: Gradient {
        
        switch self {
        case .assesmentPlayground:
            .defaultWhite(reversed: true)
        case .movemedical:
            .defaultMovemedical(reversed: true)
        case .endava:
            .defaultEndava(reversed: true)
        }
    }
}
