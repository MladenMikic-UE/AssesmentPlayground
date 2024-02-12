//
//  ActionGradient.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

struct ActionGradient: ViewModifier {
    
    var progress: CGFloat = 0
    var animatedGradientRange: AnimatedGradient
    var frame: CGSize

    func body(content: Content) -> some View {
        
        content
            .background(
                Rectangle()
                    .animatable(gradientRange: animatedGradientRange,
                                progress: progress)
            )
            .frame(width: frame.width, height: frame.width)
        
    }
}

struct AppButtonBackground: ViewModifier {
    
    var color: Color
    var frame: CGSize
    
    func body(content: Content) -> some View {
        
        content
            .background(
                Circle()
                    .fill(color)
                    .frame(width: frame.width, height: frame.width)
            )
    }
}
