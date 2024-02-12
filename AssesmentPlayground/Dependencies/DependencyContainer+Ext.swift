//
//  DependencyContainer+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

extension DependencyContainer: CoordinatorFactory {
  
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        
        return AppCoordinator(
            window: window,
            navigationController: self.navigationController
        )
    }
    
    func makeMainCoordinator(parent: Coordinator, storageInteractor: StorageInteractor) -> MainCoordinator {
        
        return MainCoordinator(
            parent: parent,
            storageInteractor: storageInteractor,
            navigationController: self.navigationController,
            factory: self,
            theme: theme,
            appViewConfiguration: appViewConfiguration
        )
    }
}

extension DependencyContainer {
    
    static let mock: DependencyContainer = DependencyContainer()
}
