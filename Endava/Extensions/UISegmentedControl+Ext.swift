//
//  UISegmentedControl+Ext.swift.swift
//  Endava
//
//  Created by Mladen Mikic on 10.02.2024.
//

import UIKit

extension UISegmentedControl {
    
    static func setAppearance(for theme: AppTheme) {
        
        let normalAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: theme.smallUIFont
        ]
        
        let selectedAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.black,
            .font: theme.smallUIFont,
        ]
        
        UISegmentedControl.appearance().backgroundColor = UIColor.black
        UISegmentedControl.appearance().selectedSegmentTintColor = theme.fontUIColor
  
        UISegmentedControl.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
