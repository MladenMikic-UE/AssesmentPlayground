//
//  AppDelegate.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import SwiftUI
import SwiftUICoordinator
import Combine

public class AppDelegate: NSObject, UIApplicationDelegate {
    
    public func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.performTargetSpecificTasks()
        return true
    }
}
