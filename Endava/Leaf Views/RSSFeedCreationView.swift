//
//  RSSFeedCreationView.swift
//  Endava
//
//  Created by Mladen Mikic on 09.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

struct RSSFeedCreationView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @StateObject var viewStates: RSSFeedCreationView.ViewStates
    @ObservedObject var viewModel: RSSFeedCreationView.ViewModel<Coordinator>
    
    private let theme: AppTheme
    // MARK: - Init.

    init(viewModel: RSSFeedCreationView<Coordinator>.ViewModel<Coordinator>,
         viewStates: RSSFeedCreationView.ViewStates = .init(),
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
    }
    
    @ViewBuilder private func buildContentContainerView() -> some View {
        
        PaddingContainerView(content: {
            
            VStack(spacing: .zero) {
                
                if self.viewStates.startAnimations {
                    
                    Picker("", selection: $viewModel.selectedCreationMethod.animation()) {
                        
                        ForEach(viewModel.creationMethods, id: \.self) { creationMethodTitle in
                            
                            Text(creationMethodTitle)
                                .font(theme.font)
                                .accentColor(.red)
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
    }
    
    @ViewBuilder private func buildContainerTabView() -> some View {
        
        if self.viewStates.startAnimations {
         
            TabView(selection: $viewModel.selectedCreationMethod) {
                
                buildCreateNewContainerView()
                    .tag(L10n.addNewObjectPickerTitle)
                    .transition(.move(edge: .leading))
                
                buildSelectNewContainerView()
                    .tag(L10n.addNewSelectedObjectPickerTitle)
                    .transition(.move(edge: .trailing))
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .transition(.popUpWithOpacityTransitionSequence)
        }
    }
    
    @ViewBuilder private func buildCreateNewContainerView() -> some View {
        
        ZStack {
            
            Color.clear

            VStack(spacing: .zero) {
                
                ScrollView {
                    
                    if self.viewStates.startAnimations {
                        
                        buildURLCreationContainerView()
                        
                        buildTitleCreationContainerView()
                    }
                }
                
                Spacer().frame(height: appViewConfiguration.appPadding.bottom)
                
                buildFinisButtonView(isRSSFeedValid: viewModel.isCreatedObjectValid,
                                     opacityLevel: viewModel.newRSSFeedOpacityLevel,
                                     title: L10n.addNewObjectFinishTitle) {
                    viewModel.createNewObjectButtonTapped()
                }
            }
        }
        .cornerRadius(appViewConfiguration.cornerRadius)
        .shadow(color: theme.shadowColor,
                radius: theme.regularButtonShadowMetadata.radius,
                x: theme.regularButtonShadowMetadata.x,
                y: theme.regularButtonShadowMetadata.y)
    }
    
    @ViewBuilder private func buildSelectNewContainerView() -> some View {
        
        ZStack {
            
            Color.clear
            
            VStack(spacing: .zero) {
                
                ForEach(viewModel.remoteRSSFeedRepository.rssFeeds, id: \.self) { rssFeed in
                    
                    Button {
                        withAnimation {
                            viewModel.selectedRSSFeed = rssFeed
                        }
                    } label: {
                        
                        VStack(spacing: .zero) {
                            Spacer()
                            
                            Text(rssFeed.title)
                                .font(theme.smallFont)
                                .foregroundColor(rssFeed == viewModel.selectedRSSFeed ? Color.black : Color.white)
                                .frame(maxWidth: .infinity)

                            Spacer()
                        }
                    }
                    .compositingGroup()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: appViewConfiguration.regularButtonSize.height)
                    .if(rssFeed == viewModel.selectedRSSFeed, transform: { v in
                        v.background(
                            RoundedRectangle(cornerSize: appViewConfiguration.regularButtonSize)
                                .fill(theme.fontColor)
                        )
                    })
                    .if(rssFeed != viewModel.selectedRSSFeed, transform: { v in
                        v.overlay(
                            RoundedRectangle(cornerRadius: appViewConfiguration.regularButtonSize.width)
                                .stroke(Color.black, lineWidth: 2)
                            )
                    })
                    // The horizontal border is cut by 1-2 points. Hotfix.
                   .padding(.horizontal, 2)
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                }
                
                Spacer().frame(minHeight: appViewConfiguration.appPadding.bottom)
                
                buildFinisButtonView(isRSSFeedValid: viewModel.isSelectedObjectValid,
                                     opacityLevel: viewModel.selectedRSSFeedOpacityLevel,
                                     title: L10n.addNewSelectedObjectFinishTitle) {
                    viewModel.createNewSelectedObjectButtonTapped()
                }
            }
            // The top is cut by 1 points. Hotfix.
           .padding(.top, 1)
        }
        .cornerRadius(appViewConfiguration.cornerRadius)
        .shadow(color: theme.shadowColor,
                radius: theme.regularButtonShadowMetadata.radius,
                x: theme.regularButtonShadowMetadata.x,
                y: theme.regularButtonShadowMetadata.y)
    }
    
    @ViewBuilder private func buildFinisButtonView(isRSSFeedValid: Bool,
                                                   opacityLevel: CGFloat,
                                                   title: String,
                                                   action: @escaping () -> Void) -> some View {
        
        if self.viewStates.startAnimations {
            
            Button {
                withAnimation {
                    action()
                }
            } label: {
                
                VStack(spacing: .zero) {
                    Spacer()
                    
                    Text(title)
                        .font(theme.smallFont)
                        .foregroundColor(isRSSFeedValid ? Color.black : theme.fontColor)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: appViewConfiguration.regularButtonSize.height)
            .background(
                RoundedRectangle(cornerSize: appViewConfiguration.regularButtonSize)
                    .fill(isRSSFeedValid ? theme.primaryFontColor: Color.black.opacity(opacityLevel))
            )
            .shadow(color: theme.shadowColor,
                    radius: theme.regularButtonShadowMetadata.radius,
                    x: theme.regularButtonShadowMetadata.x,
                    y: theme.regularButtonShadowMetadata.y)
            .disabled(!isRSSFeedValid)
            .transition(.popUpWithOpacityTransitionSequence)
        }
    }
    
    @ViewBuilder private func buildURLCreationContainerView() -> some View {
        
        DropDownContainerView(content: {
       
            VStack(spacing: .zero) {
                
                Spacer().frame(height: appViewConfiguration.appPadding.top)
                
                TextField(L10n.addNewObjectUrlPlaceholderDescription, text: $viewModel.rssFeedURL)
                    .padding(.all, 10)
                    .lineLimit(nil)
                    .font(theme.smallFont)
                    .foregroundColor(Color.black)
                    .accentColor(Color.black)
                    .frame(minHeight: appViewConfiguration.bigButtonSize.height, alignment: .topLeading)
                    .overlay(
                        RoundedRectangle(cornerRadius: appViewConfiguration.cornerRadius)
                            .stroke(viewModel.rssFeedURL.isEmpty ? Color.black : Color.clear, lineWidth: 2)
                        )
                    .background(viewModel.rssFeedURL.isEmpty ? Color.white : theme.fontColor)
                    .cornerRadius(appViewConfiguration.cornerRadius)
                
            }
        }, enteredValue: .constant("URL: \(viewModel.rssFeedURL)"),
                              selectionColor: !viewModel.rssFeedURL.isEmpty ? theme.selectionColor : Color.black,
                              viewState: $viewStates.rssFeedURLViewState,
                              theme: theme)
        .transition(.popUpWithOpacityTransitionSequence)
    }
    
    @ViewBuilder private func buildTitleCreationContainerView() -> some View {
        
        DropDownContainerView(content: {
       
            VStack(spacing: .zero) {
                
                Spacer().frame(height: appViewConfiguration.appPadding.top)
                
                TextField(L10n.addNewObjectTitlePlaceholderDescription, text: $viewModel.rssFeedTitle)
                    .padding(.all, 10)
                    .lineLimit(nil)
                    .font(theme.smallFont)
                    .foregroundColor(Color.black)
                    .accentColor(Color.black)
                    .frame(minHeight: appViewConfiguration.bigButtonSize.height, alignment: .topLeading)
                    .overlay(
                        RoundedRectangle(cornerRadius: appViewConfiguration.cornerRadius)
                            .stroke(viewModel.rssFeedTitle.isEmpty ? Color.black : Color.clear, lineWidth: 2)
                        )
                    .background(viewModel.rssFeedTitle.isEmpty ? Color.white : theme.fontColor)
                    .cornerRadius(appViewConfiguration.cornerRadius)
                
                Spacer().frame(height: appViewConfiguration.appPadding.bottom)
            }
        }, enteredValue: .constant("\(L10n.addNewObjectUrlTitle)\(viewModel.rssFeedTitle)"),
                              selectionColor: !viewModel.rssFeedTitle.isEmpty ? theme.selectionColor : Color.black,
                              viewState: $viewStates.rssFeedTitleViewState,
                              theme: theme)
        .transition(.popUpWithOpacityTransitionSequence)
    }
}
