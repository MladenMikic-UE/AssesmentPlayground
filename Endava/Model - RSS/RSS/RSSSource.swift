//
//  RSSSource.swift
//  RSS Feed
//
//  Created by Borinschi Ivan on 20.04.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import Foundation
import FeedKit


class RSSSource: UniqueCodableClass {
    
    // MARK: - Identifiable.
    var id: String { title + url }
    let title: String
    let url: String
    // TODO: Refactor articles to be loaded.
    var articles: [RSSArticle]? {
        
        didSet {
            
            guard let articles: [RSSArticle] = articles else {
                return
            }
            
            try? UserDefaults.standard.setObject(articles, forKey: id)
        }
    }
    
    var updated: Bool = false
    
    // MARK: - Init.
    /// RSS Source
    /// - Parameters:
    ///   - title: String
    ///   - url: String
    internal init(title: String, url: String) {
        
        self.title = title
        self.url = url
        super.init()
        
        if let result = try? UserDefaults.standard.getObject(forKey: id, castTo: [RSSArticle].self) {
            self.articles = result
        }
    }

    // MARK: - Equatable.
    static func == (lhs: RSSSource, rhs: RSSSource) -> Bool {
        lhs.title == rhs.title && lhs.url == rhs.url
    }
    
    // MARK: - Hashable.
    public override func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Codable.
    private enum CodingKeys: CodingKey {
        case title
        case url
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        super.init()
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
    }
}
