//
//  CoordinatorFactory.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
protocol CoordinatorFactory {
    
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator
    func makeMainCoordinator(parent: Coordinator, storageInteractor: StorageInteractor) -> MainCoordinator
}
