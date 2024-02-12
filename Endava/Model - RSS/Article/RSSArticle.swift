//
//  RSSArticle.swift
//  Endava
//
//  Created by Borinschi Ivan on 20.04.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import Foundation

class RSSArticle: UniqueCodableClass {

    var id: String {
        title + (description ?? "")
    }
    let title: String
    let description: String?
    let date: Date
    let link: String
    var author: String?
    var image: URL?
    
    init(title: String,
         description: String? = nil,
         date: Date, link: String,
         author: String? = nil,
         image: URL? = nil) {
        
        self.title = title
        self.description = description
        self.date = date
        self.link = link
        self.author = author
        self.image = image
        super.init()
    }
    
    public override func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Codable.
    private enum CodingKeys: CodingKey {
        case title
        case description
        case date
        case link
        case author
        case image
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.date = try container.decode(Date.self, forKey: .date)
        self.link = try container.decode(String.self, forKey: .link)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.image = try container.decodeIfPresent(URL.self, forKey: .image)

        super.init()
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(date, forKey: .date)
        try container.encode(link, forKey: .link)
        try container.encode(author, forKey: .author)
        try container.encode(image, forKey: .image)
    }
}

extension RSSArticle {
    
    func isValid() -> Bool {
        
        /// Apple will reject app if articles or app info will contain information about covid and pandemy
        let exclude = ["covid",
                       "covid-19",
                       "virus",
                       "pandemy",
                       "corona",
                       "infection",
                       "vaccin",
                       "cov-19"]
        
        // Filtred articles
        let filtered: [RSSArticle] = [self].filter { (article) -> Bool in
            let match = exclude.filter { article.allContentString().lowercased().range(of:$0) != nil }.count != 0
            return !match
        }
        
        return !filtered.isEmpty
    }
}
