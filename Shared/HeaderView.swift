//
//  HeaderView.swift
//  Shared
//
//  Created by Mladen Mikic on 11.02.2024.
//

import SwiftUI

public struct HeaderView: View {
    
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    private let title: String
    private let theme: AppTheme
    private let height: CGFloat
    private let fixedHeight: CGFloat?
    
    // MARK: - Init.
    /// - Parameters:
    ///   - title: The header title.
    ///   - theme: The theme used for coloring the view layout.
    ///   - height: The ideal height that should be used.
    ///   - fixedHeight: If this height is available it will be used.
    public init(title: String,
                theme: AppTheme,
                height: CGFloat = .infinity,
                fixedHeight: CGFloat?) {
        
        self.title = title
        self.theme = theme
        self.height = height
        self.fixedHeight = fixedHeight
    }
    
    public var body: some View {
        
        HStack(spacing: .zero) {
                        
            Text(title)
                .font(theme.bigFont)
                .foregroundColor(theme.primaryFontColor)
                .lineLimit(nil)
                .transition(.popUpWithOpacityTransitionSequence)
          
            Spacer()
        }
        .if(fixedHeight != nil, transform: { v in
            v.frame(height: fixedHeight ?? 40)
        })
        .if(height != .infinity && fixedHeight == nil, transform: { v in
            v.frame(idealHeight: height)
        })
    }
}
