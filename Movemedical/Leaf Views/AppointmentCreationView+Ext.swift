//
//  AppointmentCreationView+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import SwiftUI
import Combine
import SwiftUICoordinator

extension AppointmentCreationView {
    
    @MainActor
    final class ViewModel<R: Routing>: ObservableObject {
 
        @Published var date: Date
        @Published var description: String
        @Published var location: String
        @Published var isAppointmentDataValid: Bool
        @Published private(set) var storageInteractor: StorageInteractor
        var opacityLevel: Double {
            var opacityLevel: Double = 0.2
            opacityLevel += isValid(newDate: date) ? 0.2: 0.0
            opacityLevel += isValid(newLocation: description) ? 0.2: 0.0
            opacityLevel += isValid(newDescription: location) ? 0.2: 0.0
            return opacityLevel
        }
        var coordinator: R?
        let availableLocations: [String]
        
        private(set) var oldAppointment: Appointment?
        private(set) var nowDate: Date
        private var cancellable: AnyCancellable?
        private let dateFormatter: DateFormatter = DateFormatter()
        
        init(date: Date = .now,
             description: String = "",
             location: String = "",
             isAppointmentDataValid: Bool = false,
             storageInteractor: StorageInteractor,
             availableLocations: [String],
             coordinator: R?,
             oldAppointment: Appointment? = nil) {
            
            self.nowDate = Date.now
            self.date = date
            self.description = description
            self.location = location
            self.availableLocations = availableLocations
            self.storageInteractor = storageInteractor
            self.isAppointmentDataValid = isAppointmentDataValid
            self.coordinator = coordinator
            self.oldAppointment = oldAppointment
        
            setupPublishers()
            
            // Old data needs to be loaded after publishers are setup. This will update the UI correctly.
            if let oldAppointment: Appointment = self.oldAppointment {
                self.date = oldAppointment.date
                self.description = oldAppointment.description
                self.location = oldAppointment.location
            }
        }
        
        private func setupPublishers() {
            
            cancellable = Publishers.CombineLatest3($date, $description, $location)
                .receive(on: RunLoop.main)
                .sink { [weak self] result in
                    
                    guard let self else {
                        return
                    }
                    
                    let isAppointmentDataValid: Bool = self.isValid(newDate: result.0) && self.isValid(newLocation: result.2) && self.isValid(newDescription: result.1)
                    self.isAppointmentDataValid = isAppointmentDataValid
                }
        }
        
        public func createAppointmentButtonTapped() {
            
            let appointment: Appointment = .init(id: date.getFormattedDate(format: "yyyy-MM-dd HH:mm"), date: date, location: location, description: description)
            
            if let oldAppointment: Appointment = oldAppointment {
                self.storageInteractor.remove(item: oldAppointment)
                self.storageInteractor.store(item: appointment)
                self.coordinator?.handle(Action.cancel(oldAppointment))
            } else {
                self.storageInteractor.store(item: appointment)
                self.coordinator?.handle(Action.cancel(self))
            }
        }
        
        private func isValid(newDate: Date) -> Bool { newDate > self.nowDate }
        private func isValid(newLocation: String) -> Bool { self.availableLocations.contains(newLocation) }
        private func isValid(newDescription: String) -> Bool { !newDescription.isEmpty }
    }
    
    final class ViewStates: ObservableObject {
        
        @Published var locationViewState: RawViewState
        @Published var dateViewState: RawViewState
        @Published var descriptionViewState: RawViewState
        @Published var scheduleButtonViewState: RawViewState
        @Published var startAnimations: Bool
        
        init(locationViewState: RawViewState = .glance,
             dateViewState: RawViewState = .glance,
             descriptionViewState: RawViewState = .glance,
             scheduleButtonViewState: RawViewState = .full,
             startAnimations: Bool = false) {
            
            self.locationViewState = locationViewState
            self.dateViewState = dateViewState
            self.descriptionViewState = descriptionViewState
            self.scheduleButtonViewState = scheduleButtonViewState
            self.startAnimations = startAnimations
        }
    }
}
