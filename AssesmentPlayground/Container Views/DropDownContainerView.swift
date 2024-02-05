//
//  DropDownContainerView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import SwiftUI

struct DropDownContainerView<Content>: View where Content: View {
    
    @Binding var enteredValue: String
    @Binding var viewState: ViewState
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    private let content: Content
    private let selectionColor: Color
    private let theme: AppTheme
    
    public init(@ViewBuilder content: () -> Content,
                enteredValue: Binding<String>,
                selectionColor: Color,
                viewState: Binding<ViewState>,
                theme: AppTheme) {
        self.content = content()
        self.selectionColor = selectionColor
        self._enteredValue = enteredValue
        self._viewState = viewState
        self.theme = theme
    }
    
    var body: some View {

        VStack(spacing: .zero) {
            
            Spacer().frame(height: appViewConfiguration.appPadding.top)
            
            Button {
                viewState = viewState.toggledValue
            } label: {
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    VStack(spacing: .zero) {
                        
                        Spacer()
                        
                        Text(enteredValue)
                            .font(theme.smallFont)
                            .foregroundColor(theme.fontColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: appViewConfiguration.regularButtonSize.height)
                    
                    Spacer()
                    
                    VStack(spacing: .zero) {
                        
                        Spacer()
                        
                        buildChevronImageView()
                            .padding(.top, 2)
                            .defaultAppButtonBackground(color: selectionColor, frame: appViewConfiguration.regularButtonSize)
                            .shadow(color: theme.shadowColor,
                                    radius: theme.regularButtonShadowMetadata.radius,
                                    x: theme.regularButtonShadowMetadata.x,
                                    y: theme.regularButtonShadowMetadata.y)
                        
                        Spacer()
                    }
                    .frame(height: appViewConfiguration.regularButtonSize.height)
                    .frame(width: appViewConfiguration.regularButtonSize.width)

                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                .frame(maxWidth: .infinity)

            }
            .frame(maxWidth: .infinity)
            
            if viewState == .full {
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    content
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
            }
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
        }
    }
    
    @ViewBuilder private func buildChevronImageView() -> some View {
        
        if viewState == .full {
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 18)
                .foregroundColor(theme.selectionColor)
                .rotationEffect(.degrees(270))
        } else {
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 18)
                .foregroundColor(theme.fontColor)
                .rotationEffect(.degrees(90))
        }
    }
}
