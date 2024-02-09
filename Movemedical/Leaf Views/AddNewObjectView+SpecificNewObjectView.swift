//
//  AddNewObjectView+SpecificNewObjectView.swift
//  Movemedical
//
//  Created by Mladen Mikic on 09.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

public extension AddNewObjectView {
    
    @ViewBuilder func buildTargetSpecificCreateNewObjectView() -> some View {
        
        AppointmentCreationView<MainCoordinator>(theme: theme,
                                                 viewModel: .init(storageInteractor: viewModel.storageInteractor,
                                                                  availableLocations: HospitalRepository().locations,
                                                                  coordinator: coordinator as? MainCoordinator,
                                                                  oldAppointment: viewModel.oldModel as? Appointment))

    }
}
