//
//  StorageInteractor+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 10.02.2024.
//

import Foundation

extension StorageInteractor {
    
    func loadSpecificDataModelType() {
        self.load(type: Appointment.self)
    }
    
    func autoStore() {
        self.store(type: Appointment.self)
    }
}
