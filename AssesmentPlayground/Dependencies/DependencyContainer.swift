//
//  DependencyContainer.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/09/2023.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
final class DependencyContainer {
    
    let factory: NavigationControllerFactory
    @Published private(set) var storageInteractor: StorageInteractor
    lazy var delegate = factory.makeNavigationDelegate([FadeTransition()])
    lazy var navigationController = factory.makeNavigationController(delegate: delegate)

    let theme: AppTheme = AppTheme.bundleTheme
    
    let appViewConfiguration: AppViewConfiguration
    
    private(set) var appCoordinator: AppCoordinator?
    
    init(factory: NavigationControllerFactory? = nil,
         storageInteractor: StorageInteractor = .init(diskStorageClient: nil, storagePath: Bundle.storagePath),
         appViewConfiguration: AppViewConfiguration = .init(),
         appCoordinator: AppCoordinator? = nil) {
        
        print("storagePath: \(Bundle.storagePath)")
        if let efactory: NavigationControllerFactory = factory {
            self.factory = efactory
        } else {
            self.factory = .init()
        }
        
        self.storageInteractor = storageInteractor
        self.appViewConfiguration = appViewConfiguration
        self.appCoordinator = appCoordinator
        
        UIBarButtonItem.appearance().tintColor = UIColor(theme.fontColor)
        
        let clearNavAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        clearNavAppearance.configureWithOpaqueBackground()
        clearNavAppearance.backgroundColor = .clear
        clearNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        clearNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.clear]
                      
        UINavigationBar.appearance().standardAppearance = clearNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = clearNavAppearance
    }
    
    func set(_ coordinator: AppCoordinator) {
        
        guard appCoordinator == nil else {
            return
        }
        
        self.appCoordinator = coordinator
    }
}
