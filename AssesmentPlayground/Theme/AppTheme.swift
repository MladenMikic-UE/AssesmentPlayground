//
//  AppTheme.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

public enum AppTheme: String, CaseIterable {
    
    case white
    case movemedical
    case endava
    
    /// Localized theme description.
    var description: String {
        
        switch self {
        case .white:
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
        case .white:
            "White"
        case .movemedical:
            "Movemedical"
        case .endava:
            "Endava"
        }
    }
}

// MARK: - Fonts.
extension AppTheme {
    
    var bigFont: Font {
        
        switch self {
        case .white:
            Font.custom("Helvetica", size: 24)
        case .movemedical:
            Font.custom("Futura", size: 24)
        case .endava:
            Font.custom("Verdana", size: 24)
        }
    }
    
    var smallFont: Font {
        
        switch self {
        case .white:
            Font.custom("Helvetica", size: 16)
        case .movemedical:
            Font.custom("Futura", size: 16)
        case .endava:
            Font.custom("Verdana", size: 16)
        }
    }
    
    var font: Font {
        
        switch self {
        case .white:
            Font.custom("Helvetica", size: 20)
        case .movemedical:
            Font.custom("Futura", size: 20)
        case .endava:
            Font.custom("Verdana", size: 20)
        }
    }
}

// MARK: - Colors.
extension AppTheme {
    
    var selectionColor: Color {
        Color(red: 0.09, green: 0.23, blue: 0.92, opacity: 1.00)
    }
    
    var backgroundColor: Color {
        
        switch self {
        case .white:
            Color.white
        case .movemedical:
            Color(red: 0.02, green: 0.04, blue: 0.08, opacity: 1.00)
        case .endava:
            Color(red: 0.09, green: 0.15, blue: 0.19, opacity: 1.00)
        }
    }
    
    var fontColor: Color {
        
        switch self {
        case .white, .movemedical, .endava:
            Color.white
        }
    }
    
    var shadowColor: Color {
        primaryFontColor.opacity(0.45)
    }
    
    var regularButtonShadowMetadata: ShadowViewMetadata {
        return ShadowViewMetadata(radius: 2, x: 1, y: 1)
    }
    
    var bigButtonShadowMetadata: ShadowViewMetadata {
        return ShadowViewMetadata(radius: 4, x: 2, y: 4)
    }

    var primaryFontColor: Color {
        
        switch self {
        case .white:
                .white
        case .movemedical:
                .white
        case .endava:
                .white
        }
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
        case .white:
            .defaultWhite()
        case .movemedical:
            .defaultMovemedical()
        case .endava:
            .defaultEndava()
        }
    }
    
    var bottomHeavyGradient: Gradient {
        
        switch self {
        case .white:
            .defaultWhite()
        case .movemedical:
            .defaultMovemedical()
        case .endava:
            .bottomHeavyEndava()
        }
    }
    
    var reversedGradient: Gradient {
        
        switch self {
        case .white:
            .defaultWhite(reversed: true)
        case .movemedical:
            .defaultMovemedical(reversed: true)
        case .endava:
            .defaultEndava(reversed: true)
        }
    }
}
