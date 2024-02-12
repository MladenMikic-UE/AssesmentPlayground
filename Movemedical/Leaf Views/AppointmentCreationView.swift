//
//  AppointmentCreationView.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import SwiftUI
import SwiftUICoordinator

struct AppointmentCreationView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @StateObject var viewStates: AppointmentCreationView.ViewStates
    @ObservedObject var viewModel: AppointmentCreationView.ViewModel<Coordinator>
    
    @State private var descriptionText: String
    private let theme: AppTheme
    
    init(theme: AppTheme, 
         viewModel: AppointmentCreationView.ViewModel<Coordinator>,
         viewStates: AppointmentCreationView.ViewStates = .init()) {
        
        self.theme = theme
        self._viewStates = StateObject(wrappedValue: viewStates)
        self.viewModel = viewModel
        self.descriptionText = viewModel.oldAppointment?.description ?? ""
    }
    
    var body: some View {
        
        buildContentView()
            .onAppear {
                withAnimation {
                    viewStates.startAnimations = true
                }
            }
            // Fix: The default shows the navigation bar as a compact sized empty top view.
            .hiddenNavigationBarStyle()
    }
    
    @ViewBuilder private func buildContentView() -> some View {
        
        ZStack {
            
            ScrollView {
                
                if viewStates.startAnimations {
                    
                    buildDateSelectionContainerView()

                    buildLocationSelectionContainerView()
                    
                    buildDescriptionCreationContainerView()
                }
            }
            
            if viewStates.startAnimations {
                
                VStack(spacing: .zero) {
                    
                    Spacer()
                    
                    buildScheduleButtonView()
                }
                .transition(.popUpFromBottomTransitionSequence)
            }
        }
    }
    
    @ViewBuilder private func buildDateSelectionContainerView() -> some View {
        
        DropDownContainerView(content: {
            
            DatePicker("", selection: $viewModel.date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
                .environment(\.colorScheme, .light)
                .labelsHidden()
                .colorMultiply(theme.fontColor)
                .accentColor(theme.fontColor)
                .tint(theme.selectionColor)
                .transition(.opacity)
            
        }, enteredValue: .constant(L10n.addNewObjectDateTitle + viewModel.date.getFormattedDate(format: "yyyy-MM-dd HH:mm")),
                              selectionColor: (viewModel.date > viewModel.nowDate) ? theme.selectionColor : Color.black,
                              viewState: $viewStates.dateViewState,
                              theme: theme)
    }
    
    @ViewBuilder private func buildLocationSelectionContainerView() -> some View {
        
        DropDownContainerView(content: {
       
            VStack(spacing: .zero) {
                
                Spacer().frame(height: appViewConfiguration.appPadding.top)
                
                ForEach(viewModel.availableLocations, id: \.self) { location in
                    
                    Button {
                        withAnimation {
                            viewModel.location = location
                        }
                    } label: {
                        
                        VStack(spacing: .zero) {
                            Spacer()
                            
                            Text(location)
                                .font(theme.smallFont)
                                .foregroundColor(location == viewModel.location ? Color.black : theme.fontColor)
                                .frame(maxWidth: .infinity)

                            Spacer()
                        }
                    }
                    .compositingGroup()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: appViewConfiguration.regularButtonSize.height)
                    .if(location == viewModel.location, transform: { v in
                        v.background(
                            RoundedRectangle(cornerSize: appViewConfiguration.regularButtonSize)
                                .fill(theme.selectionColor)
                        )
                    })
                    .if(location != viewModel.location, transform: { v in
                        v.overlay(
                            RoundedRectangle(cornerRadius: appViewConfiguration.regularButtonSize.width)
                                .stroke(Color.black, lineWidth: 2)
                            )
                    })

                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                }
            }
        }, enteredValue: .constant("\(L10n.addNewObjectLocationTitle)\(viewModel.location)"),
                              selectionColor: (viewModel.availableLocations.contains(viewModel.location)) ? theme.selectionColor : Color.black,
                              viewState: $viewStates.locationViewState,
                              theme: theme)
        .transition(.popUpWithOpacityTransitionSequence)

    }
    
    @ViewBuilder private func buildDescriptionCreationContainerView() -> some View {
        
        DropDownContainerView(content: {
       
            VStack(spacing: .zero) {
                
                Spacer().frame(height: appViewConfiguration.appPadding.top)
                
                TextField("", text: $descriptionText)
                    .padding(.all, 10)
                    .lineLimit(nil)
                    .font(theme.smallFont)
                    .foregroundColor(Color.black)
                    .accentColor(Color.black)
                    .frame(minHeight: appViewConfiguration.bigButtonSize.height, alignment: .topLeading)
                    .overlay(
                        RoundedRectangle(cornerRadius: appViewConfiguration.cornerRadius)
                            .stroke(viewModel.description.isEmpty ? Color.black : Color.clear, lineWidth: 2)
                        )
                    .onSubmit {
                        viewModel.description = descriptionText
                    }
                    .background(viewModel.description.isEmpty ? Color.clear : theme.selectionColor)
                    .cornerRadius(appViewConfiguration.cornerRadius)
                
            }
        }, enteredValue: .constant("\(L10n.addNewObjectDescriptionTitle)\(viewModel.description)"),
                              selectionColor: !viewModel.description.isEmpty ? theme.selectionColor : Color.black,
                              viewState: $viewStates.descriptionViewState, 
                              theme: theme)
        .transition(.popUpWithOpacityTransitionSequence)
    }
    
    @ViewBuilder private func buildScheduleButtonView() -> some View {
        
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            Button {
                withAnimation {
                    viewModel.createAppointmentButtonTapped()
                }
            } label: {
                
                VStack(spacing: .zero) {
                    Spacer()
                    
                    Text(viewModel.oldAppointment == nil ? L10n.addNewObjectFinishTitle : L10n.editNewObjectFinisTitle)
                        .font(theme.smallFont)
                        .foregroundColor(viewModel.isAppointmentDataValid ? Color.black : theme.fontColor)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: appViewConfiguration.regularButtonSize.height)
            .background(
                RoundedRectangle(cornerSize: appViewConfiguration.regularButtonSize)
                    .fill(viewModel.isAppointmentDataValid ? theme.selectionColor: Color.black.opacity(viewModel.opacityLevel))
            )
            .shadow(color: theme.shadowColor, radius: 2, x: 1, y: 2)
            .disabled(!viewModel.isAppointmentDataValid)
            
            Spacer().frame(width: appViewConfiguration.appPadding.right)
        }
    }
}
