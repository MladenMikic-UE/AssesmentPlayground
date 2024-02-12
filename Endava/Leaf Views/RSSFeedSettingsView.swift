//
//  RSSFeedSettingsView.swift
//  Endava
//
//  Created by Mladen Mikic on 10.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

struct RSSFeedSettingsView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @StateObject var viewStates: RSSFeedSettingsView.ViewStates
    @ObservedObject var viewModel: RSSFeedSettingsView.ViewModel<Coordinator>
    
    private let theme: AppTheme
    // MARK: - Init.

    init(viewModel: RSSFeedSettingsView<Coordinator>.ViewModel<Coordinator>,
         viewStates: RSSFeedSettingsView.ViewStates = .init(),
         theme: AppTheme) {
        
        self.viewModel = viewModel
        self._viewStates = StateObject(wrappedValue: viewStates)
        self.theme = theme
        UISegmentedControl.setAppearance(for: theme)
    }
    
    var body: some View {
        
        buildContentContainerView()
            .onAppear {
                viewModel.coordinator = coordinator
                withAnimation {
                    self.viewStates.startAnimations = true
                }
            }
            .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder private func buildContentContainerView() -> some View {
        
        ThemeContainerView(content: {
            
            PaddingContainerView(content: {
                
                VStack(spacing: .zero) {
                    
                    if self.viewStates.startAnimations {
                        
                        Picker("", selection: $viewModel.selectedTab.animation()) {
                            
                            ForEach(viewModel.tabs, id: \.self) { tabTitle in
                                
                                Text(tabTitle)
                                    .font(theme.font)
                                    .accentColor(theme.fontColor)
                            }
                        }
                        .pickerStyle(.segmented)
                        .shadow(color: theme.shadowColor,
                                radius: theme.regularButtonShadowMetadata.radius,
                                x: theme.regularButtonShadowMetadata.x,
                                y: theme.regularButtonShadowMetadata.y)
                        .transition(.popUpWithOpacityTransitionSequence)
                    }
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    buildContainerTabView()
                }
            }, padding: appViewConfiguration.appPadding.modified(bottom: 0))

            
        }, theme: theme)
    }
    
    @ViewBuilder private func buildContainerTabView() -> some View {
        
        if self.viewStates.startAnimations {
            
            TabView(selection: $viewModel.selectedTab) {
                
                buildAllArticlesContainerView()
                    .tag(L10n.settingsAllArticlesTabTitle)
                    .transition(.move(edge: .leading))
                
                buildSettingsContainerView()
                    .tag(L10n.settingsSettingsTabTitle)
                    .transition(.move(edge: .trailing))
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .transition(.popUpWithOpacityTransitionSequence)
        }
    }
  
    @ViewBuilder private func buildAllArticlesContainerView() -> some View {
        
        ZStack {
            
            LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                .cornerRadius(appViewConfiguration.cornerRadius)
                .compositingGroup()
                .shadow(color: theme.shadowColor,
                        radius: theme.regularButtonShadowMetadata.radius,
                        x: theme.regularButtonShadowMetadata.x,
                        y: theme.regularButtonShadowMetadata.y)
            
            if viewModel.model.articles == nil {
                
                IndicatorBuilder.build(intent: .web,
                                       theme: theme,
                                       viewConfiguration: appViewConfiguration)
            } else {
             
                RSSArticleListView<MainCoordinator>(articles: .constant(viewModel.model.articles ?? []),
                                   theme: theme) { article in
                    viewModel.showDetail(for: article)
                }
            }
        }
        .transition(.popUpWithOpacityTransitionSequence)
    }
     
    @ViewBuilder private func buildSettingsContainerView() -> some View {
        
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
    }
    
    @ViewBuilder private func buildContentView() -> some View {
        
        PaddingContainerView(content: {
            
            VStack(spacing: .zero) {
                            
                HStack(spacing: .zero) {
                                        
                    if viewStates.startAnimations {
                        
                        Text(L10n.settingsHeaderTitle)
                            .font(theme.bigFont)
                            .foregroundColor(theme.primaryFontColor)
                            .transition(.popUpWithOpacityTransitionSequence)
                    }
                  
                    Spacer()
                    
                    buildDeleteButton()
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                Spacer().frame(height: appViewConfiguration.appPadding.bottom)
                
                buildSettingsViewContainer()
            }
            
        }, padding: appViewConfiguration.appPadding)
    }
    
    @ViewBuilder private func buildDeleteButton() -> some View {
        
        if viewStates.startAnimations {
         
            DeleteButton(theme: theme) {
                self.viewModel.deleteObjectButtonTapped()
            }
            .transition(.popUpWithOpacityTransitionSequence)
        }
    }
    
    @ViewBuilder private func buildSettingsViewContainer() -> some View {
        
        ScrollView {
            
            VStack(spacing: appViewConfiguration.appPadding.top) {
             
                buildWebPageAccessSettingsSection()
                
                buildNotificationSettingsSection()
            }
        }
        .cornerRadius(appViewConfiguration.cornerRadius)
    }
    
    @ViewBuilder private func buildWebPageAccessSettingsSection() -> some View {
        
        if viewStates.startAnimations {
            
            VStack(spacing: appViewConfiguration.appPadding.top) {
                
                Spacer().frame(height: 1)
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    buildRSSFeedListItemView(text: viewModel.model.title) {
                        viewModel.openWebpage(url: viewModel.model.webPageURL)
                    }
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    buildRSSFeedListItemView(text: L10n.settingsRssTitle) {
                        viewModel.openWebpage(url: URL(string: viewModel.model.url))
                    }
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                   
                    buildRSSFeedSettingsToggleView(toggleTitle: L10n.settingsOpenWebPagesTitle, isOn: $viewModel.openWebPagesExernally)
                
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                Spacer().frame(height: 1)
            }
            .compositingGroup()
            .frame(maxWidth: .infinity)
            .transition(.popUpWithOpacityTransitionSequence)
            .background(theme.backgroundColor.opacity(0.1))
            .cornerRadius(appViewConfiguration.cornerRadius)
        }
    }
  
    @ViewBuilder private func buildNotificationSettingsSection() -> some View {
        
        if viewStates.startAnimations {
            
            VStack(spacing: appViewConfiguration.appPadding.top) {
                
                Spacer().frame(height: 1)
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    buildRSSFeedSettingsToggleView(toggleTitle: L10n.settingsDissableRssFeedTitle, isOn: $viewModel.isRSSFeedDisabled)
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    buildRSSFeedSettingsToggleView(toggleTitle: L10n.settingsDissableRssFeedArticlesTitle, isOn: $viewModel.isRSSFeedArticlesFetchingDisabled)

                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                HStack(spacing: .zero) {
                    
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                   
                    buildRSSFeedSettingsToggleView(toggleTitle: L10n.settingsDissableRssFeedPushNotificationsTitle, isOn: $viewModel.isRSSFeedPushNotificationsFetchingDisabled)
                
                    Spacer().frame(width: appViewConfiguration.appPadding.right)
                }
                
                Spacer().frame(height: 1)
            }
            .compositingGroup()
            .frame(maxWidth: .infinity)
            .transition(.popUpWithOpacityTransitionSequence)
            .background(theme.backgroundColor.opacity(0.1))
            .cornerRadius(appViewConfiguration.cornerRadius)
        }
    }
    
    @ViewBuilder private func buildRSSFeedListItemView(text: String, _ action: @escaping () -> Void) -> some View {
     
        Button(action: action) {
            
            VStack(spacing: .zero) {
                
                Spacer()
                                     
                HStack(spacing: .zero) {
                                             
                    Spacer().frame(width: appViewConfiguration.appPadding.left)
                    
                    VStack(spacing: .zero) {
                        
                        Spacer()
                        
                        Text(text)
                            .font(theme.smallFont)
                            .foregroundColor(theme.fontColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 16)
                         
                        Spacer()
                    }
                    
                    HStack(spacing: .zero) {
                        
                        Spacer().frame(width: appViewConfiguration.appPadding.right)
                        
                        if viewModel.openWebPagesExernally {
                            ChevronRightImageView(theme: theme)
                        } else {
                            SafarImageView(theme: theme)
                        }
                        
                        Spacer().frame(width: appViewConfiguration.appPadding.right / 2)
                        
                        if viewModel.openWebPagesExernally {
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
    
    @ViewBuilder private func buildRSSFeedSettingsToggleView(toggleTitle: String, isOn: Binding<Bool>) -> some View {
     
        VStack(spacing: .zero) {
            
            Spacer()
                                 
            HStack(spacing: .zero) {
                                         
                Spacer().frame(width: appViewConfiguration.appPadding.left)
                
                VStack(spacing: .zero) {
                    
                    Spacer()
                    
                    Text(toggleTitle)
                        .font(theme.miniFont)
                        .foregroundColor(theme.fontColor)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                
                Spacer().frame(width: appViewConfiguration.appPadding.left / 2.0)
                
                Toggle(isOn: isOn, label: { EmptyView() })
                    .frame(width: 50)
                    .tint(Color.black)
                
                Spacer().frame(width: appViewConfiguration.appPadding.right)
            }
            .frame(height: appViewConfiguration.bigButtonSize.height)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: appViewConfiguration.bigButtonSize.height)
        .overlay(
            RoundedRectangle(cornerRadius: appViewConfiguration.cornerRadius)
                .stroke(Color.black.opacity(0.1), lineWidth: 2)
            )
         // The horizontal border is cut by 1-2 points. Hotfix.
        .padding(.horizontal, 2)
    }
}

#Preview {
    RSSFeedSettingsView<MainCoordinator>(viewModel: .init(coordinator: nil, model: .init(title: "", url: ""), storageInteractor: .init(diskStorageClient: nil, storagePath: "")), theme: .assesmentPlayground)
}
