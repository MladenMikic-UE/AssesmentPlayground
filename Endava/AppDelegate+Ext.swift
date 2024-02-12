//
//  AppDelegate+Ext.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import Foundation
import BackgroundTasks

public extension AppDelegate {
    
    func performTargetSpecificTasks() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.rss.news.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        
        scheduleNextUpdate()
        
        let dataSubscriber = RSSDataSubscriber()
        
        dataSubscriber.dataDidUpdate = { _ in
            task.setTaskCompleted(success: true)
        }
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        RSSDataParser.shared.update()
    }
    
    func scheduleNextUpdate() {
        
        let request = BGAppRefreshTaskRequest(identifier: "com.rss.news.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
}
