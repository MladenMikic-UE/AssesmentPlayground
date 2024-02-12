//
//  CloseButton.swift
//  Shared
//
//  Created by Mlade nMikic on 10.02.2024.
//

import SwiftUI

public struct CloseButton: View {
    
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
        
    private let theme: AppTheme
    private let action: () -> Void
    
    public init(theme: AppTheme, action: @escaping () -> Void) {
        self.theme = theme
        self.action = action
    }
    
    public var body: some View {
     
        Button(action: action) {
            
            VStack(spacing: .zero) {
                
                Spacer()
                
                Text("x")
                    .font(theme.font)
                    .foregroundColor(theme.fontColor)
                    .frame(alignment: .center)
                    .padding(.top, -4)
                Spacer()
            }
            .frame(height: appViewConfiguration.regularButtonSize.height)
        }
        .defaultAppButtonBackground(color: Color.black, frame: appViewConfiguration.regularButtonSize)
        .shadow(color: theme.shadowColor,
                radius: theme.regularButtonShadowMetadata.radius,
                x: theme.regularButtonShadowMetadata.x,
                y: theme.regularButtonShadowMetadata.y)
    }
}

#Preview {
    CloseButton(theme: .assesmentPlayground, action: {})
}
