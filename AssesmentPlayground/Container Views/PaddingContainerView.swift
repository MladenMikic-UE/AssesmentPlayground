//
//  PaddingContainerView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

public struct PaddingContainerView<Content>: View where Content: View {
    
    private let content: Content
    private let padding: UIEdgeInsets
    
    public init(@ViewBuilder content: () -> Content, padding: UIEdgeInsets) {
        self.content = content()
        self.padding = padding
    }

    public var body : some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: padding.top)
            
            HStack(spacing: .zero) {
                
                Spacer().frame(width: padding.left)
                
                content
                
                Spacer().frame(width: padding.right)
            }
            
            Spacer().frame(height: padding.bottom)
        }
    }
}
