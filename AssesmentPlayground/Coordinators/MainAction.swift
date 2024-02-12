//
//  MainAction.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import SwiftUICoordinator

enum MainAction: CoordinatorAction {
    
    case addNewObject
    case edit(object: UniqueCodableClass)
    case openWebpage(url: URL)
    case detail(object: UniqueCodableClass)
}
