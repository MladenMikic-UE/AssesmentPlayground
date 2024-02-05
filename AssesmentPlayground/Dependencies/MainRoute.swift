//
//  MainRoute.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import SwiftUICoordinator

enum MainRoute: NavigationRoute {
    
    case main
    case addNewObject
    case edit(object: UniqueCodableClass)

    var title: String? {
        
        switch self {
        case .main:
            return ""
        case .addNewObject:
            return "Add New"
        case .edit(_):
            return "Edit"
        }
    }

    var action: TransitionAction? {
        
        switch self {
        case .addNewObject:
            // We have to pass nil for the route presenting a child coordinator.
            return .present(animated: true, modalPresentationStyle: .automatic, delegate: nil) {}
        case .edit(_):
            return .push(animated: true)
        default:
            return .push(animated: true)
        }
    }
}

extension MainRoute: Equatable {
    
    static func == (lhs: MainRoute, rhs: MainRoute) -> Bool {
        
        switch (lhs, rhs) {
        case (.main, .main): return true
        case (.addNewObject, .addNewObject): return true
        case (.edit(let lObject), edit(let rObject)): return lObject == rObject
        default: return false
        }
    }
}
