//
//  MainCoordinator.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import SwiftUI
import SwiftUICoordinator

class MainCoordinator: Routing {

    // MARK: - Internal properties
    weak var parent: Coordinator?
    let storageInteractor: StorageInteractor
    var childCoordinators: [WeakCoordinator] = [WeakCoordinator]()
    let navigationController: NavigationController
    let startRoute: MainRoute
    let factory: CoordinatorFactory
    let theme: AppTheme
    let appViewConfiguration: AppViewConfiguration

    // MARK: - Initialization
    init(parent: Coordinator?,
         storageInteractor: StorageInteractor,
         navigationController: NavigationController,
         startRoute: MainRoute = .main,
         factory: CoordinatorFactory,
         theme: AppTheme,
         appViewConfiguration: AppViewConfiguration) {
        
        self.parent = parent
        self.storageInteractor = storageInteractor
        self.navigationController = navigationController
        self.startRoute = startRoute
        self.factory = factory
        self.theme = theme
        self.appViewConfiguration = appViewConfiguration
    }
     
    func handle(_ action: CoordinatorAction) {
        
        switch action {
        case MainAction.addNewObject:
            try? show(route: .addNewObject)
        case MainAction.edit(let object):
            try? show(route: .edit(object: object))
        case Action.done(let object), Action.cancel(let object):
            if let eObject: UniqueCodableClass = object as? UniqueCodableClass {
                self.pop()
            } else {
                self.dismiss(animated: true)
            }
        case MainAction.openWebpage(let url):
            try? show(route: .webpage(url: url))
        case MainAction.detail(let object):
            try? show(route: .detail(object: object))
        default:
            parent?.handle(action)
        }
    }
    
    func handle(_ deepLink: DeepLink, with params: [String: String]) {
        // Used for deeplink implementation in the SwiftUICoordinator example.
    }
}
