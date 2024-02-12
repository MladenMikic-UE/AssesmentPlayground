//
//  AppViewConfiguration.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import Foundation
import SwiftUI

fileprivate let defaultPaddingValue: CGFloat = 20.0

class AppViewConfiguration: ObservableObject {
    
    let regularButtonSize: CGSize = .init(width: 44, height: 44)
    let bigButtonSize: CGSize = .init(width: 66, height: 66)
    let hugeButtonSize: CGSize = .init(width: 88, height: 88)
    
    let gradientAnimationDuration: CGFloat = 4.0
    let indicatorSize: CGSize = .init(width: 44, height: 44)
    let buttonImageSize: CGSize = .init(width: 22, height: 22)
    
    let appPadding: UIEdgeInsets = .init(top: defaultPaddingValue,
                                         left: defaultPaddingValue,
                                         bottom: defaultPaddingValue,
                                         right: defaultPaddingValue)
    
    let cornerRadius: CGFloat = defaultPaddingValue
}

extension UIEdgeInsets {
    
    func modified(top: CGFloat = defaultPaddingValue,
                  left: CGFloat = defaultPaddingValue,
                  bottom: CGFloat = defaultPaddingValue,
                  right: CGFloat = defaultPaddingValue) -> UIEdgeInsets {
        
        UIEdgeInsets(top: top != defaultPaddingValue ? top : self.top,
                     left: left != defaultPaddingValue ? left : self.left,
                     bottom: bottom != defaultPaddingValue ? bottom : self.bottom,
                     right: right != defaultPaddingValue ? right : self.right)
    }
}
