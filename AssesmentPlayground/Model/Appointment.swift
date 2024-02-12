//
//  Appointment.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation

class Appointment: UniqueCodableClass {
    
    let id: String
    let date: Date
    let location: String
    let description: String
    
    init(id: String,
         date: Date,
         location: String,
         description: String) {
        
        self.id = id
        self.date = date
        self.location = location
        self.description = description
        super.init()
    }
    
    // MARK: - Codable.
    private enum CodingKeys: CodingKey {
        case id
        case date
        case location
        case description
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.location = try container.decode(String.self, forKey: .location)
        self.description = try container.decode(String.self, forKey: .description)
        super.init()
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(location, forKey: .location)
        try container.encode(description, forKey: .description)
    }
}
