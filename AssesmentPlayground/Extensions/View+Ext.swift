//
//  View+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import Foundation
import SwiftUI
import Combine

extension View {
    
    func animatable(gradientRange: AnimatedGradient, progress: CGFloat) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: gradientRange.original, toGradient: gradientRange.reversed, progress: progress))
    }
    
    func actionGradient(with progress: CGFloat, animatedGradientRange: AnimatedGradient, frame: CGSize) -> some View {
        modifier(ActionGradient(progress: progress, animatedGradientRange: animatedGradientRange, frame: frame))
    }
    
    func defaultAppButtonBackground(color: Color, frame: CGSize) -> some View {
        modifier(AppButtonBackground(color: color, frame: frame))
    }
    
    // Source: https://www.avanderlee.com/swiftui/conditional-view-modifier/
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    // Source: https://www.swiftbysundell.com/articles/building-swiftui-debugging-utilities/
    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
#if DEBUG
        return modifier(self)
#else
        return self
#endif
    }
    
    /// Add a border for debug builds.
    func debugBorder(_ color: Color = .random, width: CGFloat = 1) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }
    
    /// Add a background color for debug builds.
    func debugBackground(_ color: Color = .random) -> some View {
        debugModifier {
            $0.background(color)
        }
    }
}
