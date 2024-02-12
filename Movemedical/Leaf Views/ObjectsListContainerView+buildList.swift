//
//  ObjectsListContainerView+buildList.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 10.02.2024.
//

import SwiftUI

extension MainCoordinatorView {
    
    @ViewBuilder public func buildFilledContentView() -> some View {
        
        if self.viewState.startAnimations {
            
            ObjectsListContainerView<MainCoordinator>(viewModel: .init(coordinator: coordinator as? MainCoordinator,
                                                                       storageInteractor: viewModel.storageInteractor),
                                                      theme: theme)
            .transition(.popUpWithOpacityTransitionSequence)
        }
    }
}

extension ObjectsListContainerView {
  
    @ViewBuilder public func buildListView() -> some View {
        
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
          // The horizontal border is cut by 1-2 points. Hotfix.
         .padding(.horizontal, 2)
    }
}
