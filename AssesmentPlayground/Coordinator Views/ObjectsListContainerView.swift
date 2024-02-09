//
//  ObjectsListContainerView.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import SwiftUI
import SwiftUICoordinator

struct ObjectsListContainerView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    @ObservedObject var viewModel: ViewModel<Coordinator, UniqueCodableClass>
    
    @ObservedObject private var viewState: MainCoordinatorView<MainCoordinator>.ViewState = MainCoordinatorView<MainCoordinator>.ViewState()
    @State private var theme: AppTheme
    
    // MARK: - Init.
    init(viewModel: ViewModel<Coordinator, UniqueCodableClass>,
        theme: AppTheme) {
        self.viewModel = viewModel
        self.theme = theme
    }
    
    var body: some View {
        
        buildContentContainerView()
            .onAppear {
                withAnimation {
                    self.viewState.startAnimations = true
                }
            }
    }
    
    @ViewBuilder private func buildContentContainerView() -> some View {

        ThemeContainerView(content: {
            
            PaddingContainerView(content: {
                
                VStack(spacing: .zero) {
                    
                    if self.viewState.startAnimations {
                        
                        buildHeaderContainerView()
                            .transition(.popUpWithOpacityTransitionSequence)
                    }
                 
                    if self.viewState.startAnimations {
                     
                        ZStack {
                            
                            LinearGradient(gradient: theme.bottomHeavyGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                                .cornerRadius(appViewConfiguration.cornerRadius)
                            
                            buildBodyContentView()
                        }
                        .transition(.popUpWithOpacityTransitionSequence)
                    }
                }
            }, padding: .zero)
            .compositingGroup()
            .shadow(color: theme.shadowColor, radius: 2, x: 1, y: 2)

        }, theme: theme)
    }
    
    // MARK: - Header Views.
    
    @ViewBuilder private func buildHeaderContainerView() -> some View {

        VStack(spacing: .zero) {
            
            Spacer().frame(height: appViewConfiguration.appPadding.top)
            
            HStack(spacing: .zero) {
                
                Spacer().frame(width: appViewConfiguration.appPadding.left)
                
                if self.viewState.startAnimations {
                    
                    buildHeaderView()
                        .transition(.popUpWithOpacityTransitionSequence)
                }
                
                Spacer()
                
                if self.viewState.startAnimations {
                    
                    buildHeaderControlView()
                        .transition(.popUpWithOpacityTransitionSequence)

                }
                
                Spacer().frame(width: appViewConfiguration.appPadding.left)
            }
            
            Spacer().frame(height: appViewConfiguration.appPadding.bottom)
        }
    }
    
    @ViewBuilder private func buildHeaderView() -> some View {
        Text("Appointments")
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
        .onAppear {
            withAnimation(.linear(duration: appViewConfiguration.gradientAnimationDuration).repeatForever(autoreverses: true)) {
                self.viewState.leftButtonProgress = 1.0
            }
        }
    }
    
    // MARK: - Body Views.
    
    @ViewBuilder private func buildBodyContentView() -> some View {
        
        switch theme {
        case .assesmentPlayground:
            EmptyView()
        case .movemedical:
            buildMoveMedicalListView()
        case .endava:
            EmptyView()
        }
    }
    
    @ViewBuilder private func buildMoveMedicalListView() -> some View {
        
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            ScrollView {
             
                VStack(spacing: appViewConfiguration.appPadding.top) {
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    ForEach(viewModel.models, id: \.self) { item in
                        
                        if let appoitment: Appointment = item as? Appointment {
                            buildAppointmentListItemView(model: appoitment)
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
            
            Spacer().frame(width: appViewConfiguration.appPadding.right)
        }
    }
    
    @ViewBuilder private func buildAppointmentListItemView(model: Appointment) -> some View {
     
         Button {
             withAnimation {
                 viewModel.editObjectButtonTapped(with: model)
             }
         } label: {
             
             ZStack {
                 
                 VStack(spacing: .zero) {
                     
                     Spacer()
                                      
                     HStack(spacing: .zero) {
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left * 2)
                         
                         Image(systemName: "calendar")
                             .resizable()
                             .foregroundColor(theme.primaryFontColor)
                             .frame(width: 16, height: 16)
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left)
                         
                         VStack(spacing: .zero) {
                             
                             Spacer()
                             
                             Text(model.date.getFormattedDate(format: "yyyy-MM-dd HH:mm"))
                                 .font(theme.smallFont)
                                 .foregroundColor(theme.fontColor)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .frame(height: 16)

                             Spacer()
                         }
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.right * 2)
                     }
                     .frame(height: appViewConfiguration.regularButtonSize.height / 1.6)
                     
                     Spacer().frame(height: 2)
                     
                     HStack(spacing: .zero) {
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left * 2)
                         
                         Image(systemName: "location")
                             .resizable()
                             .foregroundColor(theme.primaryFontColor)
                             .frame(width: 16, height: 16)
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left)
                         
                         VStack(spacing: .zero) {
                             
                             Spacer()
                             
                             Text(model.location)
                                 .font(theme.smallFont)
                                 .foregroundColor(theme.fontColor)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .frame(height: 16)

                             Spacer()
                         }
                                                  
                         Spacer().frame(width: appViewConfiguration.appPadding.right * 2)
                     }
                     .frame(height: appViewConfiguration.regularButtonSize.height / 1.6)
                     
                     Spacer()
                 }
              
                 HStack(spacing: .zero) {
                     
                     Spacer()
                     
                     VStack(spacing: .zero) {
                        
                         Spacer()
                         
                         Image(systemName: "chevron.right")
                             .resizable()
                             .frame(width: 10, height: 18, alignment: .center)
                             .foregroundColor(theme.fontColor)
                         
                         Spacer()
                     }
                     
                     Spacer().frame(width: appViewConfiguration.appPadding.right * 2)
                 }
             }
         }
         .compositingGroup()
         .frame(maxWidth: .infinity, alignment: .leading)
         .frame(height: appViewConfiguration.bigButtonSize.height)
         .overlay(
             RoundedRectangle(cornerRadius: appViewConfiguration.bigButtonSize.width)
                 .stroke(Color.black, lineWidth: 2)
             )
         .padding(.horizontal, 2)
    }
}
