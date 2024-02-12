//
//  MainCoordinatorTabView.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import SwiftUI
import SwiftUICoordinator

struct MainCoordinatorTabView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @ObservedObject var viewModel: MainCoordinatorTabView.ViewModel<Coordinator>
    @State public private(set) var theme: AppTheme
    @State public private(set) var viewState: MainCoordinatorTabView<MainCoordinator>.ViewState = .init()
    
    // MARK: - Init.
    init(theme: AppTheme,
         viewModel: MainCoordinatorTabView.ViewModel<Coordinator>) {
        
        self.theme = theme
        self.viewModel = viewModel
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor(theme.backgroundColor)
    }
    
    var body: some View {
        
        buildContentContainerView()
            .onAppear {
                withAnimation {
                    viewState.startAnimations = true
                }
            }
            // Fix: The default shows the navigation bar as a compact sized empty top view.
            .hiddenNavigationBarStyle()
    }
    
    @ViewBuilder private func buildContentContainerView() -> some View {
    
        TabView {
            buildArticlesTab()
                .tabItem {
                    Label(L10n.mainTabArticlesTitle, systemImage: "book.closed.fill")
                }
                .tag(0)
                .transition(.move(edge: .leading))
            
            buildRSSFeedsTab()
                .tabItem {
                    Label(L10n.mainListObjectHeaderTitle, systemImage: "books.vertical.fill")
                }
                .tag(1)
                .transition(.move(edge: .leading))
            
            buildFavoritesTab()
                .tabItem {
                    Label(L10n.mainTabFavouritesTitle, systemImage: "star.fill")
                }
                .tag(2)
                .transition(.move(edge: .leading))
        }
            .tint(theme.fontColor)
            // The views start to move up and down without the animation nil. Insanity and madness.
            // Source: https://stackoverflow.com/questions/75874531/swiftui-subviews-move-up-and-down-when-wrapped-in-navigationview
            .animation(nil)
    }
    
    // MARK: - Build Tabs.
    @ViewBuilder private func buildArticlesTab() -> some View {
        
        if viewState.startAnimations {
            
            ThemeContainerView(content: {
                
                VStack(spacing: .zero) {
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    buildHeaderView(title: L10n.mainTabArticlesTitle)
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    ZStack {
                        
                        LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                        .cornerRadius(appViewConfiguration.cornerRadius)
                            .compositingGroup()
                            .shadow(color: theme.shadowColor,
                                    radius: theme.regularButtonShadowMetadata.radius,
                                    x: theme.regularButtonShadowMetadata.x,
                                    y: theme.regularButtonShadowMetadata.y)
                        
                        buildArticlesTabContentView()
                    }
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.bottom)
                }
            }, theme: theme)
            .hiddenNavigationBarStyle()
        }
    }
    
    @ViewBuilder private func buildRSSFeedsTab() -> some View {
        
        if viewState.startAnimations {
            
            ThemeContainerView(content: {
                
                PaddingContainerView(content: {
                    
                    ObjectsListContainerView<MainCoordinator>(viewModel: .init(coordinator: coordinator as? MainCoordinator,
                                                                               storageInteractor: viewModel.storageInteractor),
                                                              theme: theme)
                    .transition(.popUpWithOpacityTransitionSequence)
                    
                }, padding: appViewConfiguration.appPadding.modified(top: 0, left: 0, right: 0))
            }, theme: theme)
            .hiddenNavigationBarStyle()
        }
    }
    
    @ViewBuilder private func buildFavoritesTab() -> some View {
       
        if viewState.startAnimations {
            
            ThemeContainerView(content: {
                
                VStack(spacing: .zero) {
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    buildHeaderView(title: L10n.mainTabFavouritesTitle)
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    ZStack {
                        
                        LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(appViewConfiguration.cornerRadius)
                            .compositingGroup()
                            .shadow(color: theme.shadowColor,
                                    radius: theme.regularButtonShadowMetadata.radius,
                                    x: theme.regularButtonShadowMetadata.x,
                                    y: theme.regularButtonShadowMetadata.y)
                        
                        buildFavouritesTabContentView()
                    }
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.bottom)
                }
            }, theme: theme)
            .hiddenNavigationBarStyle()
        }
    }
    
    @ViewBuilder private func buildArticlesTabContentView() -> some View {
        
        if viewState.startAnimations {
            
            if viewModel.articles.isEmpty {
                
                CenteredContainerView {
                    
                    if viewState.startAnimations {
                        
                        IndicatorBuilder.build(intent: .web, theme: theme, viewConfiguration: appViewConfiguration)
                            .transition(.popUpWithOpacityTransitionSequence)
                    }
                }
            } else {
                             
                RSSArticleListView<MainCoordinator>(articles: $viewModel.articles,
                                                    theme: theme) { article in
                    viewModel.showDetail(for: article)
                }
                .transition(.popUpWithOpacityTransitionSequence)
            }
        }
    }
    
    @ViewBuilder private func buildFavouritesTabContentView() -> some View {
        
        if viewState.startAnimations {
            
            VStack(spacing: .zero) {
                
                Spacer()
                
                Text("TODO: Build Fav Content")
                    .font(theme.font)
                    .foregroundColor(theme.fontColor)
                
                Spacer()
            }
            .transition(.popUpWithOpacityTransitionSequence)
        }
    }
    
    @ViewBuilder private func buildHeaderView(title: String) -> some View {
        
        if viewState.startAnimations {
            
            HeaderView(title: title, theme: theme, fixedHeight: appViewConfiguration.regularButtonSize.height)
        }
    }
}
