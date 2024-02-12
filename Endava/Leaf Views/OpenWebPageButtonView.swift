//
//  OpenWebPageButtonView.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import SwiftUI

struct OpenWebPageButtonView: View {
    
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
        
    private let title: String
    private let theme: AppTheme
    private let action: () -> Void
    
    internal init(title: String, theme: AppTheme, action: @escaping () -> Void) {
        self.title = title
        self.theme = theme
        self.action = action
    }
    
    var body: some View {
        
        Button(action: action) {
            
            VStack(spacing: .zero) {
                
                Spacer()
                                     
                HStack(spacing: .zero) {
                                             
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    VStack(spacing: .zero) {
                        
                        Spacer()
                        
                        Text(title)
                            .font(theme.smallFont)
                            .foregroundColor(theme.fontColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 16)
                         
                        Spacer()
                    }
                    
                    HStack(spacing: .zero) {
                        
                        Spacer().frame(width: appViewConfiguration.appPadding.right)
                        
                        if UserDefaults.openAllWebPagesOutsideOfTheApp {
                            ChevronRightImageView(theme: theme)
                        } else {
                            SafarImageView(theme: theme)
                        }
                        
                        Spacer().frame(width: appViewConfiguration.appPadding.right / 2)
                        
                        if UserDefaults.openAllWebPagesOutsideOfTheApp {
                            SafarImageView(theme: theme)
                        } else {
                            ChevronRightImageView(theme: theme)
                        }
                        
                        Spacer().frame(width: appViewConfiguration.appPadding.right)
                    }
                    .background(
                       RoundedRectangle(cornerRadius: appViewConfiguration.regularButtonSize.height)
                           .fill(Color.black)
                           .frame(height: appViewConfiguration.regularButtonSize.height)
                    )
                }
                .frame(height: appViewConfiguration.regularButtonSize.height / 1.6)
                
                Spacer()
            }
        }
        .compositingGroup()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: appViewConfiguration.regularButtonSize.height)
        .overlay(
            RoundedRectangle(cornerRadius: appViewConfiguration.regularButtonSize.width)
                .stroke(Color.black, lineWidth: 2)
            )
         // The horizontal border is cut by 1-2 points. Hotfix.
        .padding(.horizontal, 2)

    }
}
