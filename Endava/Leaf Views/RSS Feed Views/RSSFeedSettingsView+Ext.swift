//
//  RSSFeedSettingsView+Ext.swift
//  Endava
//
//  Created by Mladen Mikic on 10.02.2024.
//

import SwiftUI
import Combine
import SwiftUICoordinator

extension RSSFeedSettingsView {
    
    @MainActor
    final class ViewModel<R: Routing>: ObservableObject {
 
        var coordinator: R?
        @Published var selectedTab: String
        let tabs: [String]
        @Published var storageInteractor: StorageInteractor
        private(set) var model: RSSSource
        @Published var openWebPagesExernally: Bool
        @Published var isRSSFeedDisabled: Bool
        @Published var isRSSFeedArticlesFetchingDisabled: Bool
        @Published var isRSSFeedPushNotificationsFetchingDisabled: Bool
        private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
       
        // MARK: - Init.
        init(coordinator: R?, 
             model: RSSSource, 
             storageInteractor: StorageInteractor,
             selectedTab: String = L10n.settingsAllArticlesTabTitle,
             tabs: [String] = [L10n.settingsAllArticlesTabTitle, L10n.settingsSettingsTabTitle]) {
            
            self.coordinator = coordinator
            self.selectedTab = selectedTab
            self.tabs = tabs
            self.model = model
            self.storageInteractor = storageInteractor
            self.openWebPagesExernally = UserDefaults.openAllWebPagesOutsideOfTheApp
            // TODO: Refactor into state machine.
            // TODO: Test: Write unit tests.
            switch model.availabilityState {
            case .disabled:
                self.isRSSFeedDisabled = true
                self.isRSSFeedArticlesFetchingDisabled = true
                self.isRSSFeedPushNotificationsFetchingDisabled = true
            case .disabledArticles:
                self.isRSSFeedDisabled = false
                self.isRSSFeedArticlesFetchingDisabled = true
                self.isRSSFeedPushNotificationsFetchingDisabled = false
            case .disabledPushNotifications:
                self.isRSSFeedDisabled = false
                self.isRSSFeedArticlesFetchingDisabled = false
                self.isRSSFeedPushNotificationsFetchingDisabled = true
            case .enabled:
                self.isRSSFeedDisabled = false
                self.isRSSFeedArticlesFetchingDisabled = false
                self.isRSSFeedPushNotificationsFetchingDisabled = false
            }
            setupPublishers()
        }
        
        private func setupPublishers() {
            
            // TODO: Refactor into state machine.
            Publishers.CombineLatest3($isRSSFeedDisabled, $isRSSFeedArticlesFetchingDisabled, $isRSSFeedPushNotificationsFetchingDisabled)
                .receive(on: RunLoop.main)
                .sink { [weak self] isRSSFeedDisabled, isRSSFeedArticlesFetchingDisabled, isRSSFeedPushNotificationsFetchingDisabled  in
                    
                    guard let self else {
                        return
                    }
                    
                    switch (isRSSFeedDisabled, isRSSFeedArticlesFetchingDisabled, isRSSFeedPushNotificationsFetchingDisabled) {
                        case (true, true, true): 
                        self.model.availabilityState = .disabled
                        case (true, false, true):
                        self.model.availabilityState = .disabled
                        case (true, true, false):
                        self.model.availabilityState = .disabled
                        case (true, false, false):
                        self.model.availabilityState = .disabled
                        case (false, true, false):
                        self.model.availabilityState = .disabledArticles
                        case (false, false, true):
                        self.model.availabilityState = .disabledPushNotifications
                        case (false, false, false):
                        self.model.availabilityState = .enabled
                        default: break
                    }
                
                    let log =
                    """
                        
                        isRSSFeedDisabled: \(isRSSFeedDisabled)
                        isRSSFeedArticlesFetchingDisabled: \(isRSSFeedArticlesFetchingDisabled)
                        isRSSFeedPushNotificationsFetchingDisabled: \(isRSSFeedPushNotificationsFetchingDisabled)
                    
                        self.model.availabilityState: \(self.model.availabilityState)
                    """
                    print(log)
                }
                .store(in: &bag)
            
            $openWebPagesExernally.sink { openWebPagesExernally in
                UserDefaults.openAllWebPagesOutsideOfTheApp = openWebPagesExernally
            }
            .store(in: &bag)
        }
        
        func deleteObjectButtonTapped() {
            
            storageInteractor.remove(item: model)
            coordinator?.handle(Action.done(model))
        }
        
        func openWebpage(url: URL?) {
            
            guard let eURL: URL = url else {
                return
            }
            if openWebPagesExernally {
                UIApplication.shared.open(eURL)
            } else {
                coordinator?.handle(MainAction.openWebpage(url: eURL))
            }
        }
        
        func showDetail(for article: RSSArticle) {
            coordinator?.handle(MainAction.detail(object: article))
        }
    }
    
    final class ViewStates: ObservableObject {
        
        @Published var startAnimations: Bool
        
        init(startAnimations: Bool = false) {
            
            self.startAnimations = startAnimations
        }
    }
}

