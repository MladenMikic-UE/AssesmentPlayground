//
//  SceneDelegate+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 11.02.2024.
//

import Foundation
import SwiftUI
import BackgroundTasks

extension SceneDelegate {
    
    func handlesSceneDidBecomeActive(_ scene: UIScene) {
        
        // Update rss feed
        RSSDataParser.shared.update()
    }
    
    func handleSceneDidEnterBackground(_ scene: UIScene) {
        
        let request = BGAppRefreshTaskRequest(identifier: "com.rss.news.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
        
        let content = UNMutableNotificationContent()
        content.subtitle = "Articles have been updated"
        content.sound = UNNotificationSound.default
        
        // Trigger new update in next 24 hours after app did enter in background
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60 * 24, repeats: false)
        
        // Choose a random identifier
        let notificationsRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Add our notification request
        UNUserNotificationCenter.current().add(notificationsRequest)
    }
}
