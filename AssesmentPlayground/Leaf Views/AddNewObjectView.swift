//
//  AddNewObjectView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

struct AddNewObjectView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @ObservedObject var viewModel: ViewModel<Coordinator, UniqueCodableClass>
    
    @State private var theme: AppTheme
    @State private var animationsStart: Bool = false

    // MARK: - Init.
    public init(theme: AppTheme, 
                viewModel: ViewModel<Coordinator, UniqueCodableClass>) {
        self.theme = theme
        self.viewModel = viewModel
    }
    
    var body: some View {
    
        buildContentContainerView()
            .onAppear {
                viewModel.coordinator = coordinator
                withAnimation {
                    animationsStart = true
                }
            }
            .interactiveDismissDisabled()
    }
    
    @ViewBuilder private func buildContentContainerView() -> some View {
        
        ThemeContainerView(content: {
            
            PaddingContainerView(content: {
              
                ZStack {
                    
                    LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                        .cornerRadius(appViewConfiguration.cornerRadius)
                    
                    buildContentView()
                }
                
            }, padding: appViewConfiguration.appPadding)
            .compositingGroup()
            .shadow(color: theme.shadowColor,
                    radius: theme.regularButtonShadowMetadata.radius,
                    x: theme.regularButtonShadowMetadata.x,
                    y: theme.regularButtonShadowMetadata.y)

        }, theme: theme)
    }
    
    @ViewBuilder private func buildContentView() -> some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: appViewConfiguration.appPadding.top)
        
            HStack(spacing: .zero) {
                
                Spacer().frame(width: appViewConfiguration.appPadding.left)
                
                if animationsStart {
                    
                    Text(viewModel.oldModel == nil ? L10n.editNewObjectHeaderTitle : L10n.editNewObjectHeaderTitle)
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
            
            AppointmentCreationView<MainCoordinator>(theme: theme,
                                                     viewModel: .init(storageInteractor: viewModel.storageInteractor, 
                                                                      availableLocations: HospitalRepository().locations,
                                                                      coordinator: coordinator as? MainCoordinator,
                                                                      oldAppointment: viewModel.oldModel as? Appointment))
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
        }
    }
    
    @ViewBuilder private func buildCloseButton() -> some View {
                
        Button {
            self.viewModel.closeButtonTapped()
        } label: {
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
    
    @ViewBuilder private func buildDeleteButton() -> some View {
                
        Button {
            self.viewModel.deleteButtonTapped()
        } label: {
            VStack(spacing: .zero) {
                
                Spacer()
                
                Image(systemName: "trash")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: 14, height: 18)
                
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
