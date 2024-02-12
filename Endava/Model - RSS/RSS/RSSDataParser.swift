//
//  RSSDataManager.swift
//  Endava
//
//  Created by Borinschi Ivan on 20.04.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import FeedKit
import Foundation
import Combine

class RSSDataParser {
    
    static let shared: RSSDataParser = RSSDataParser()
    internal var dataPublisher: PassthroughSubject = PassthroughSubject<[RSSSource], Never>()
    internal var dataStatusPublisher: PassthroughSubject = PassthroughSubject<RSSUpdateStatus, Never>()
    
    var updateInProgress: Bool = false
    
    init() {
        
        print("\(#function) - \(#line)")
        let originalTimerUpdate: TimeInterval = 60 * 15
        Timer.scheduledTimer(timeInterval: 15,
                                         target: self,
                                         selector: #selector(fireTimer),
                                         userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        
        print("\(#function) - \(#line)")
        update()
    }
    
    public func update() {
        
        print("\(#function) - \(#line)")
        
        if readPropertyListFromServer {
            
            RSSPlistReader().getPropertyList { dictionary in
                
                let sources: [RSSSource] = dictionary.map { (key, value) in
                    RSSSource(title: key, url: value)
                }
        
                RSSSourceManager.shared.sources = sources
                self.prepareAndStartUpdate()
                
            } fail: { error in
                print(error)
                self.prepareAndStartUpdate()
            }
            
        } else {
            prepareAndStartUpdate()
        }
    }
    
    fileprivate func prepareAndStartUpdate() {
        
        print("\(#function) - \(#line)")
        
        if !updateInProgress {
            
            updateInProgress = true
            
            if RSSSourceManager.shared.shouldUpdate() {
                
                for source in RSSSourceManager.shared.sources {
                    source.updated = false
                }
                
                updateNextInQueueIfNeed()
                
            } else {
                didFinishUpdate()
            }
        }
    }
    
    internal func updateNextInQueueIfNeed() {
                
        print("\(#function) - \(#line)")
        
        // Get next source to update
        let filtered: [RSSSource] = RSSSourceManager.shared.sources.filter { (source) -> Bool in
            source.updated == false
        }
        
        DispatchQueue.main.async { [weak self] in
            let updated: Int = RSSSourceManager.shared.sources.count - filtered.count
            let total: Int = RSSSourceManager.shared.sources.count
            self?.dataStatusPublisher.send(RSSUpdateStatus(updated: updated, totalSources: total))
        }
        
        if filtered.isEmpty {
            
            RSSSourceManager.shared.setUpToDate()
            didFinishUpdate()
        } else {
            
            guard let source: RSSSource = filtered.first else {
            
                RSSSourceManager.shared.setUpToDate()
                didFinishUpdate()
                return
            }
            
            update(source: source)
        }
    }
    
    internal func didFinishUpdate() {
        
        print("\(#function) - \(#line)")
        
        DispatchQueue.main.async { [weak self] in
            self?.dataPublisher.send(RSSSourceManager.shared.sources)
            self?.updateInProgress = false
        }
    }
    
    internal func update(source: RSSSource) {
        
        print("\(#function) - \(#line)")
        
        guard let feedURL: URL = URL(string: source.url.replace(target: "\n", withString: "")) else {
            
            source.updated = true
            print("Bad source url: \(source.url)")
            updateNextInQueueIfNeed()
            return
        }
        
        let parser: FeedParser = FeedParser(URL: feedURL)
        
        // Parse asynchronously, not to block the UI.
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            
            switch result {
            case .success(let feed):
                
                switch feed {
                case let .atom(feed):
                    
                    source.articles = feed.articles()
                    
                    print("\(#function) - \(#line) - articles: \(source.articles)")
                    
                    source.updated = true
                    self.updateNextInQueueIfNeed()
                    
                case let .rss(feed):
                    
                    source.articles = feed.articles()
                    source.updated = true
                    
                    print("\(#function) - \(#line) - articles: \(source.articles)")
                    
                    self.updateNextInQueueIfNeed()
                    
                case let .json(_):
                    
                    source.articles = nil
                    source.updated = true
                    
                    print("\(#function) - \(#line) - articles: \(source.articles)")

                    self.updateNextInQueueIfNeed()
                }
                
            case .failure(_):
                                
                source.articles = nil
                source.updated = true
                
                print("\(#function) - \(#line) - articles: \(source.articles)")

                self.updateNextInQueueIfNeed()
            }
        }
    }
}
