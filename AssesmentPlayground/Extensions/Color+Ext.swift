//
//  Color+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import SwiftUI

public extension Color {
    
    // Source: https://gist.github.com/EnesKaraosman/efb9c2d989e51d20253976c8fb1aa734
    /// Return a reandom SwiftUI Color.
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
