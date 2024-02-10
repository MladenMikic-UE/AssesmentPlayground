//
//  RemoteRSSRepository.swift
//  Endava
//
//  Created by Mladen Mikic on 10.02.2024.
//

import Foundation

final class RemoteRSSRepository: ObservableObject {
    
    @Published private(set) var rssFeeds: [RSSSource]
     
    init(rssFeeds: [RSSSource] = rssSources) {
        self.rssFeeds = rssFeeds
    }
}
