//
//  ThemeContainerView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

public struct ThemeContainerView<Content>: View where Content: View {
    
    private let content: Content
    private let theme: AppTheme
    
    public init(@ViewBuilder content: () -> Content, theme: AppTheme) {
        self.content = content()
        self.theme = theme
    }

    public var body : some View {
        
        ZStack {
            
            theme.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            content
        }
    }
}
