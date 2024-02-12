//
//  Gradient+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

public extension Gradient {
    
    static func defaultMovemedical(reversed: Bool = false) -> Gradient {
        var colors = [Color(red: 0.20, green: 0.26, blue: 0.65, opacity: 1.00),
                      Color(red: 0.06, green: 0.82, blue: 0.71, opacity: 1.00)]
        if reversed { colors = colors.reversed() }
        return Gradient(colors: colors)
    }
    
    static func bottomHeavyEndava(reversed: Bool = false) -> Gradient {
        var colors = [Color(red: 0.09, green: 0.15, blue: 0.19, opacity: 1.00),
                      Color(red: 0.36, green: 0.67, blue: 0.90, opacity: 1.00)]
        if reversed { colors = colors.reversed() }
        return Gradient(colors: colors)
    }
    
    static func defaultEndava(reversed: Bool = false) -> Gradient {
        var colors = [Color(red: 0.09, green: 0.15, blue: 0.19, opacity: 1.00),
                      Color(red: 0.36, green: 0.67, blue: 0.90, opacity: 1.00)]
        if reversed { colors = colors.reversed() }
        return Gradient(colors: colors)
    }
    
    static func defaultWhite(reversed: Bool = false) -> Gradient {
        var colors = [Color.white,
                      Color.black]
        if reversed { colors = colors.reversed() }
        return Gradient(colors: colors)
    }
}
