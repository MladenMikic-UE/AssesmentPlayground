//
//  MainCoordinatorTabView+Ext.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import Combine
import SwiftUI
import SwiftUICoordinator

extension MainCoordinatorTabView {
    
    @MainActor class ViewModel<R: Routing>: ObservableObject {
        
        var coordinator: R?
        @Published var storageInteractor: StorageInteractor
        @Published var selectedArticle: RSSArticle?
        @Published var articles: [RSSArticle]
        // TODO: Refactor this model ->
        private let sourceManager: RSSSourceManager
        private let timeline: RSSTimeLine
        private let dataSubscriber: RSSDataSubscriber = RSSDataSubscriber()
        private let rssDataStatus: RSSDataStatusSubscriber = RSSDataStatusSubscriber()
        // <-
        private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
        
        // MARK: - Init.
        public init(storageInteractor: StorageInteractor,
                    coordinator: R?,
                    timeline: RSSTimeLine,
                    sourceManager: RSSSourceManager = .shared,
                    articles: [RSSArticle] = [],
                    selectedArticle: RSSArticle? = nil) {
            
            self.storageInteractor = storageInteractor
            self.coordinator = coordinator
            self.timeline = timeline
            self.sourceManager = sourceManager
            self.articles = articles
            self.selectedArticle = selectedArticle
            
            updateContent()
            setUpRSSUpdateSubscriber()
            setupPublishers()
        }
        
        private func setupPublishers() {
            
            storageInteractor.localStorage.$items
                .sink { [weak self] items in
                    
                    guard let self else {
                        return
                    }
                    
                    let sources: [RSSSource] = items.compactMap { $0 as? RSSSource }
                    RSSSourceManager.shared.sources = sources
                    self.updateContent()
                }
                .store(in: &bag)
        }
        
        func showDetail(for article: RSSArticle) {
            
            self.selectedArticle = article
            coordinator?.handle(MainAction.detail(object: article))
        }
        
        /// Set up rss update subscriber
        func setUpRSSUpdateSubscriber() {
            
            rssDataStatus.statusDidUpdate = { status in
                
            }
            
            dataSubscriber.dataDidUpdate = { _ in
                
                self.updateContent()
            }
        }
        
        func source(for article: RSSArticle) -> RSSSource? {
            
            let sources: [RSSSource] = RSSSourceManager.shared.sources
            let source: RSSSource? = sources.first { source in
                source.articles?.contains(article) ?? false
            }
            return source
        }
        
        private func updateContent() {
            
            let sources: [RSSSource] = RSSSourceManager.shared.sources
            let articles: [RSSArticle] = RSSTimeLine.rssFeedTimeLine(for: sources)
            /*
            let log =
            """
            
                sources: \(sources)
                f.sources.art: \(sources.first?.articles)
                articles: \(articles)

            """
            print(log)
            */
            withAnimation {
                self.articles = articles
            }
        }
    }
    
    class ViewState: ObservableObject {
        
        @Published var startAnimations: Bool
        
        // MARK: - Init.
        public init(startAnimations: Bool = true) {
            self.startAnimations = startAnimations
        }
    }
}
