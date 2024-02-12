//
//  AddNewObjectView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

public struct AddNewObjectView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @ObservedObject var viewModel: ViewModel<Coordinator, UniqueCodableClass>
    
    @State private(set) var theme: AppTheme
    @State private var animationsStart: Bool = false

    // MARK: - Init.
    public init(theme: AppTheme, 
                viewModel: ViewModel<Coordinator, UniqueCodableClass>) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    public var body: some View {
    
        buildContentContainerView()
            .onAppear {
                viewModel.coordinator = coordinator
                withAnimation {
                    animationsStart = true
                }
            }
            .interactiveDismissDisabled()
            .ignoresSafeArea(edges: .bottom)
            // Fix: The default shows the navigation bar as a compact sized empty top view.
            .hiddenNavigationBarStyle()
    }
    
    @ViewBuilder private func buildContentContainerView() -> some View {
        
        ThemeContainerView(content: {
            
            PaddingContainerView(content: {
              
                ZStack {
                    
                    LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                        .cornerRadius(appViewConfiguration.cornerRadius)
                        .compositingGroup()
                        .shadow(color: theme.shadowColor,
                                radius: theme.regularButtonShadowMetadata.radius,
                                x: theme.regularButtonShadowMetadata.x,
                                y: theme.regularButtonShadowMetadata.y)
                    
                    buildContentView()
                }
                
            }, padding: appViewConfiguration.appPadding)

        }, theme: theme)
    }
    
    @ViewBuilder private func buildContentView() -> some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: appViewConfiguration.appPadding.top)
        
            HStack(spacing: .zero) {
                
                Spacer().frame(width: appViewConfiguration.appPadding.left)
                
                if animationsStart {
                    
                    Text(viewModel.oldModel == nil ? L10n.addNewObjectHeaderTitle : L10n.editNewObjectHeaderTitle)
                        .font(theme.bigFont)
                        .foregroundColor(theme.primaryFontColor)
                        .transition(.popUpWithOpacityTransitionSequence)
                }
              
                Spacer()
                
                if animationsStart, viewModel.oldModel == nil {
                    
                    buildCloseButton()
                        .transition(.popUpWithOpacityTransitionSequence)
                } else if animationsStart, viewModel.oldModel != nil {
                    
                    buildDeleteButton()
                }
                
                Spacer().frame(width: appViewConfiguration.appPadding.right * 1.8)
            }
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
            
            buildTargetSpecificCreateNewObjectView()
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
        }
    }
    
    @ViewBuilder private func buildCloseButton() -> some View {
                
        CloseButton(theme: theme) {
            self.viewModel.closeButtonTapped()
        }
    }
    
    @ViewBuilder private func buildDeleteButton() -> some View {
             
        DeleteButton(theme: theme) {
            self.viewModel.deleteButtonTapped()
        }
    }
}
