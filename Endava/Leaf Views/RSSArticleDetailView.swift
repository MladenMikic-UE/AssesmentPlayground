//
//  RSSArticleDetailView.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

struct RSSArticleDetailView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @StateObject var viewStates: RSSArticleDetailView.ViewStates
    @ObservedObject var viewModel: RSSArticleDetailView.ViewModel<Coordinator>
    
    private let theme: AppTheme
    // MARK: - Init.

    init(viewModel: RSSArticleDetailView<Coordinator>.ViewModel<Coordinator>,
         viewStates: RSSArticleDetailView.ViewStates = .init(),
         theme: AppTheme) {
        self.viewModel = viewModel
        self._viewStates = StateObject(wrappedValue: viewStates)
        self.theme = theme
    }
    
    var body: some View {
        
        buildContentContainerView()
            .onAppear {
                viewModel.coordinator = coordinator
                withAnimation {
                    self.viewStates.startAnimations = true
                }
            }
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
            }, padding: appViewConfiguration.appPadding.modified(bottom: 0))
            
        }, theme: theme)
    }
    
    @ViewBuilder private func buildContentView() -> some View {
        
        PaddingContainerView(content: {
            
            VStack(spacing: .zero) {
                                
                HeaderView(title: viewModel.model.title, theme: theme, height: appViewConfiguration.regularButtonSize.height, fixedHeight: nil)
                
                Spacer().frame(height: appViewConfiguration.appPadding.top)
                
                ScrollView {
                                        
                    if let imageURL: URL = viewModel.model.image {
                        
                        AsyncImage(url: imageURL) { image in
                             image
                                 .resizable()
                                 .scaledToFill()
                         } placeholder: {
                             IndicatorBuilder.build(intent: .web, theme: theme, viewConfiguration: appViewConfiguration)
                         }
                         .frame(maxWidth: .infinity, maxHeight: 160)
                         .cornerRadius(appViewConfiguration.cornerRadius)
                        
                        Spacer().frame(height: appViewConfiguration.appPadding.top)
                    }
                    
                    if let description: String = viewModel.model.description {
                        
                        Text(description)
                            .font(theme.miniFont)
                            .foregroundColor(theme.fontColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                                        
                    Spacer(minLength: appViewConfiguration.appPadding.bottom)
                }
                                
                Spacer().frame(height: appViewConfiguration.appPadding.bottom)
                
                OpenWebPageButtonView(title: L10n.articleDetailOpenArticleTitle, theme: theme) {
                    viewModel.openModelWebpage()
                }
            }
        }, padding: appViewConfiguration.appPadding)
    }
}
