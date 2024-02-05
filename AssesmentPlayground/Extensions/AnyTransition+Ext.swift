//
//  AnyTransition+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

extension AnyTransition {
    
    static var popUpFromBottomTransitionSequence: AnyTransition {
        .popUpFromBottomTransition.combined(with: .opacity).combined(with: .scale)
    }
    
    static var popUpFromTrailingTransitionSequence: AnyTransition {
        .popUpTrailingBottomTransition.combined(with: .opacity).combined(with: .scale)
    }
    
    static var popUpWithOpacityTransitionSequence: AnyTransition {
        .scale.combined(with: .opacity)
    }
    
    static var popUpFromBottomTransition: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom))}
    
    static var popUpTrailingBottomTransition: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing))}

    static var pushTransitionAnimation: AnyTransition { AnyTransition.asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing)
    )}
}
