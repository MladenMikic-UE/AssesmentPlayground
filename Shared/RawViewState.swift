//
//  RawViewState.swift
//  Shared
//
//  Created by Mladen Mikic on 09.02.2024.
//

import Foundation

public enum RawViewState: Equatable {
    
    case full
    case glance
    
    public static func == (lhs: RawViewState, rhs: RawViewState) -> Bool {
        switch (lhs, rhs) {
        case (.full, .full): return true
        case (.glance, .glance): return true
        default: return false
        }
    }
    
    var toggledValue: RawViewState {
        if self == .full {
            return .glance
        } else {
            return .full
        }
    }
}
