//
//  SceneDelegate.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import SwiftUI
import SwiftUICoordinator
import Combine

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    private var dependencyContainer: DependencyContainer = DependencyContainer()
    private var appCoordinator: AppCoordinator?
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()

    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let window: UIWindow = (scene as? UIWindowScene)?.windows.first else {
            return
        }
        
        let appCoordinator: AppCoordinator = dependencyContainer.makeAppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        dependencyContainer.set(appCoordinator)
                
        // The storage loading or network fetch process might take some time.
        dependencyContainer.storageInteractor.$loadProcess.sink { [weak self] loadProcess in

            guard let self else {
                return
            }
            
            let coordinator = self.dependencyContainer.makeMainCoordinator(parent: appCoordinator,
                                                                           storageInteractor: self.dependencyContainer.storageInteractor)

            switch loadProcess {
            case .finished:
                self.appCoordinator?.start(with: coordinator)
            case .failed(let error):
                self.appCoordinator?.start(with: coordinator)
                // TODO: Add error handling. 
            default: break
            }
        }
        .store(in: &bag)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // Used for deeplink implementation in the SwiftUICoordinator example.
    }
}


