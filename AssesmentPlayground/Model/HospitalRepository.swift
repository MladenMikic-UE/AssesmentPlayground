//
//  HosipitalRepository.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import Foundation

final class HospitalRepository: ObservableObject {
    
    @Published private(set) var locations: [String]
     
    init(locations: [String] = [
        "San Diego",
        "St. George",
        "Park City",
        "Dallas",
        "Memphis",
        "Orlando"
    ]) {
        self.locations = locations
    }
}
