//
//  ContentView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI
import SwiftUICoordinator

public struct MainCoordinatorView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    @ObservedObject var viewModel: ViewModel<Coordinator>
    @State private var theme: AppTheme
    @State private var viewState: MainCoordinatorView.ViewState = .init()
    
    // MARK: - Init.
    public init(theme: AppTheme,
                viewModel: ViewModel<Coordinator>) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        buildContentView(for: viewModel.viewContentState)
            .ignoresSafeArea(.all)
            .onAppear {
                viewModel.coordinator = coordinator
                withAnimation {
                    self.viewState.startAnimations = true
                }
            }
    }
    
    @ViewBuilder private func buildContentView(for viewContentState:  MainCoordinatorView.ViewContentState) -> some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: appViewConfiguration.appPadding.top * 2)
                
            ThemeContainerView(content: {
                
                PaddingContainerView(content: {
                    
                    switch viewContentState {
                    case .loading:
                        buildLoadingContentView()
                    case .empty:
                        buildEmptyContentView()
                    case .filled:
                        buildFilledContentView()
                    }
                    
                }, padding: appViewConfiguration.appPadding)
                
            }, theme: theme)
        }
    }
    
    @ViewBuilder private func buildEmptyContentView() -> some View {
        
        VStack(spacing: .zero) {
       
            Spacer()
            
            VStack(spacing: .zero) {
                
                Spacer()
                
                if self.viewState.startAnimations {
                    
                    buildEmptyTextPlaceholderView()
                }
                
                
                Spacer()
            }
            
            HStack(spacing: .zero) {
                
                if self.viewState.startAnimations {
                    
                    buildEmptyAddButtonView()
                }
            }
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
        }
    }
    
    @ViewBuilder private func buildEmptyTextPlaceholderView() -> some View {
        
        Text(L10n.mainListNoObjectPlaceholderTitle)
            .font(theme.font)
            .foregroundColor(theme.fontColor)
            .transition(.popUpWithOpacityTransitionSequence)
    }
    
    @ViewBuilder private func buildEmptyAddButtonView() -> some View {
        
        Button(action: {
        
            viewModel.didTapAddNewObject()
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .foregroundColor(theme.primaryFontColor)
                .padding(.all, appViewConfiguration.bigButtonSize.height/4)
        })
        .actionGradient(with: viewState.leftButtonProgress,
                        animatedGradientRange: theme.animatedGradientRange,
                        frame: CGSize(width: appViewConfiguration.bigButtonSize.width,
                                      height: appViewConfiguration.bigButtonSize.height))
        .clipShape(Circle())
        .shadow(color: theme.shadowColor, 
                radius: theme.bigButtonShadowMetadata.radius,
                x: theme.bigButtonShadowMetadata.x,
                y: theme.bigButtonShadowMetadata.y)
        .onAppear {
            withAnimation(.linear(duration: appViewConfiguration.gradientAnimationDuration).repeatForever(autoreverses: true)) {
                self.viewState.leftButtonProgress = 1.0
            }
        }
        .transition(.popUpFromBottomTransitionSequence)
    }
    
    @ViewBuilder private func buildFilledContentView() -> some View {
     
        if self.viewState.startAnimations {

            ObjectsListContainerView<MainCoordinator>(viewModel: .init(coordinator: coordinator as? MainCoordinator,
                                                                       storageInteractor: viewModel.storageInteractor),
                                                      theme: theme)
                .transition(.popUpWithOpacityTransitionSequence)
        }
    }
    
    @ViewBuilder private func buildLoadingContentView() -> some View {
        
        VStack(spacing: .zero) {
            
            Spacer()
            
            HStack(spacing: .zero) {
                
                Spacer()

                if self.viewState.startAnimations {

                    IndicatorBuilder.build(intent: .disk, theme: theme, viewConfiguration: appViewConfiguration)
                        .transition(.popUpWithOpacityTransitionSequence)
                }
                
                Spacer()
            }
            
            Spacer()
        }
    }
}
