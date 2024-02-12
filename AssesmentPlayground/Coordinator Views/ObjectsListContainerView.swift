//
//  ObjectsListContainerView.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import SwiftUI
import SwiftUICoordinator

struct ObjectsListContainerView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    @ObservedObject var viewModel: ViewModel<Coordinator, UniqueCodableClass>
    
    @ObservedObject public private(set) var viewState: MainCoordinatorView<MainCoordinator>.ViewState = MainCoordinatorView<MainCoordinator>.ViewState()
    @State public var theme: AppTheme
    
    // MARK: - Init.
    init(viewModel: ViewModel<Coordinator, UniqueCodableClass>,
        theme: AppTheme) {
        self.viewModel = viewModel
        self.theme = theme
    }
    
    var body: some View {
        
        let _ = print("ObjectsListContainerView")
        
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

        ThemeContainerView(content: {
            
            PaddingContainerView(content: {
                
                VStack(spacing: .zero) {
                    
                    if viewState.startAnimations {
                        
                        buildHeaderContainerView()
                            .transition(.popUpWithOpacityTransitionSequence)
                    }
                 
                    if viewState.startAnimations {
                     
                        ZStack {
                            
                            LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                                .cornerRadius(appViewConfiguration.cornerRadius)
                                .compositingGroup()
                                .shadow(color: theme.shadowColor,
                                        radius: theme.regularButtonShadowMetadata.radius,
                                        x: theme.regularButtonShadowMetadata.x,
                                        y: theme.regularButtonShadowMetadata.y)
                            
                            buildBodyContentView()
                        }
                        .transition(.popUpWithOpacityTransitionSequence)
                    }
                }
            }, padding: .zero)
            
        }, theme: theme)
    }
    
    // MARK: - Header Views.
    
    @ViewBuilder private func buildHeaderContainerView() -> some View {

        VStack(spacing: .zero) {
            
            Spacer().frame(height: appViewConfiguration.appPadding.top)
            
            HStack(spacing: .zero) {
                                
                if viewState.startAnimations {
                    
                    buildHeaderView()
                        .transition(.popUpWithOpacityTransitionSequence)
                }
                
                Spacer()
                
                if viewState.startAnimations {
                    
                    buildHeaderControlView()
                        .transition(.popUpWithOpacityTransitionSequence)

                }
            }
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
        }
    }
    
    @ViewBuilder private func buildHeaderView() -> some View {
        
        Text(L10n.mainListObjectHeaderTitle)
            .font(theme.bigFont)
            .foregroundColor(theme.fontColor)
            .frame(alignment: .leading)
    }
    
    @ViewBuilder private func buildHeaderControlView() -> some View {
        
        Button(action: {
            withAnimation {
                viewModel.addObjectButtonTapped()
            }
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .foregroundColor(theme.primaryFontColor)
                .padding(.all, appViewConfiguration.regularButtonSize.height/4)
        })
        .actionGradient(with: viewState.leftButtonProgress,
                        animatedGradientRange: theme.animatedGradientRange,
                        frame: CGSize(width: appViewConfiguration.regularButtonSize.width,
                                      height: appViewConfiguration.regularButtonSize.height))
        .clipShape(Circle())
        .shadow(color: theme.shadowColor,
                radius: theme.regularButtonShadowMetadata.radius,
                x: theme.regularButtonShadowMetadata.x,
                y: theme.regularButtonShadowMetadata.y)
        .padding(.trailing, 2)
        .onAppear {
            withAnimation(.linear(duration: appViewConfiguration.gradientAnimationDuration).repeatForever(autoreverses: true)) {
                viewState.leftButtonProgress = 1.0
            }
        }
    }
    
    // MARK: - Body Views.
    
    @ViewBuilder private func buildBodyContentView() -> some View {
        
        buildListView()
    }
}
