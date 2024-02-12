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
    case detail(object: UniqueCodableClass)
    case webpage(url: URL)

    var title: String? {
        
        switch self {
        case .main:
            return ""
        case .addNewObject:
            return "Add New"
        case .edit(_):
            return ""
        case .webpage(_):
            return ""
        case .detail(_):
            return ""
        }
    }

    var action: TransitionAction? {
        
        switch self {
        case .edit(_), .detail(_):
            return .push(animated: true)
        case .webpage(_), .addNewObject:
            return .present(animated: true, modalPresentationStyle: .automatic, delegate: nil) {}
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
        case (.webpage(let lURL), webpage(let rURL)): return lURL == rURL
        default: return false
        }
    }
}
