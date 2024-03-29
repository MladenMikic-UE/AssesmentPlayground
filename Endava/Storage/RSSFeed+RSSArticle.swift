//
//  RSSFeed+RSSArticle.swift
//  Endava
//
//  Created by Borinschi Ivan on 21.04.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import FeedKit

extension RSSFeed {
    
    /// Get [RSSArticle] from RSSFeed
    /// - Returns: [RSSArticle]
    func articles() -> [RSSArticle]? {
        
        guard let items: [RSSFeedItem] = items else {
            return nil
        }
        
        return items.map { (item) -> RSSArticle? in
            return item.article()
        }.compactMap({ $0 })
    }
}
