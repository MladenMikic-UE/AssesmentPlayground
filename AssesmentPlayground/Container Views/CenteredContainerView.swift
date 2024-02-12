//
//  CenteredContainerView.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

public struct CenteredContainerView<Content>: View where Content: View {
    
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body : some View {
        
        VStack(spacing: .zero) {
            
            Spacer()
            
            HStack(spacing: .zero) {
                
                Spacer()
                
                content
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview {
    CenteredContainerView {
        Text("Center")
    }
}
