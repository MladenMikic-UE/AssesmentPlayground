//
//  AppViewConfiguration.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import Foundation
import SwiftUI

class AppViewConfiguration: ObservableObject {
    
    let bottomPadding: CGFloat = 20
    let regularButtonSize: CGSize = .init(width: 44, height: 44)
    let bigButtonSize: CGSize = .init(width: 66, height: 66)
    
    let gradientAnimationDuration: CGFloat = 4.0
    let indicatorSize: CGSize = .init(width: 44, height: 44)
    let buttonImageSize: CGSize = .init(width: 22, height: 22)
    
    let appPadding: UIEdgeInsets = .init(top: 20,
                                         left: 20,
                                         bottom: 20,
                                         right: 20)
    
    let cornerRadius: CGFloat = 20.0
}
