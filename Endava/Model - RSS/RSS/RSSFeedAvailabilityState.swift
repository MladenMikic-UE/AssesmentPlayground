//
//  RSSFeedAvailabilityState.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import Foundation

enum RSSFeedAvailabilityState: Codable {
    /// No  data regarding the RSS feed will be fetched. The RSS feed is completely disabled.
    case disabled
    /// No  new articles will be fetched. Notifications will still arive.
    case disabledArticles
    /// No  new push notifications will be sent. Articles will still be fetched.
    case disabledPushNotifications
    /// All relevant data will be provided.
    case enabled
}
