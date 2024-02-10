//
//  RSSFeedCreationView+Ext.swift
//  Endava
//
//  Created by Mladen Mikic on 09.02.2024.
//

import SwiftUI
import Combine
import SwiftUICoordinator

extension RSSFeedCreationView {
    
    @MainActor
    final class ViewModel<R: Routing>: ObservableObject {
 
        var coordinator: R?
        let creationMethods: [String] = [L10n.addNewObjectPickerTitle, L10n.addNewSelectedObjectPickerTitle]
        @Published var selectedCreationMethod: String = L10n.addNewObjectPickerTitle
        @Published var isCreatedObjectValid: Bool
        @Published var isSelectedObjectValid: Bool
        @Published var selectedRSSFeed: RSSSource?
        @Published var createdRSSFeed: RSSSource?
        @Published var rssFeedURL: String
        @Published var rssFeedTitle: String
        
        @Published private(set) var newRSSFeedOpacityLevel: Double = 1.0
        @Published private(set) var selectedRSSFeedOpacityLevel: Double = 1.0
        
        @Published private(set) var storageInteractor: StorageInteractor
        @Published private(set) var remoteRSSFeedRepository: RemoteRSSRepository
        
        @Published private var isRSSFeedURLValid: Bool = false
        @Published private var isRSSFeedTitleValid: Bool = false
        private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
       
        // MARK: - Init.
        init(isCreatedObjectValid: Bool = false,
             isSelectedObjectValid: Bool = false,
             storageInteractor: StorageInteractor,
             remoteRSSFeedRepository: RemoteRSSRepository = .init(),
             selectedRSSFeed: RSSSource? = nil,
             createdRSSFeed: RSSSource? = nil,
             rssFeedURL: String = "",
             rssFeedTitle: String = "",
             coordinator: R?) {
            
            self.isCreatedObjectValid = isCreatedObjectValid
            self.isSelectedObjectValid = isSelectedObjectValid
            self.storageInteractor = storageInteractor
            self.remoteRSSFeedRepository = remoteRSSFeedRepository
            self.selectedRSSFeed = selectedRSSFeed
            self.createdRSSFeed = createdRSSFeed
            self.rssFeedURL = rssFeedURL
            self.rssFeedTitle = rssFeedTitle
            self.coordinator = coordinator
        
            setupPublishers()
        }
        
        private func setupPublishers() {
            
            self.$selectedRSSFeed
                .receive(on: RunLoop.main)
                .sink { [weak self] selectedRSSFeed in
                
                    guard let self else {
                        return
                    }
                    
                    if selectedRSSFeed == nil {
                        self.isSelectedObjectValid = false
                        self.selectedRSSFeedOpacityLevel = 0.5
                    } else {
                        self.isSelectedObjectValid = true
                        self.selectedRSSFeedOpacityLevel = 1.0
                    }
                }.store(in: &bag)
            
            $rssFeedURL
                .compactMap({ rssFeedURL in
                    return rssFeedURL.validURL
                })
                .receive(on: DispatchQueue.main)
                .assign(to: &$isRSSFeedURLValid)
            
            $rssFeedTitle
                .compactMap({ rssFeedTitle in
                    return !rssFeedTitle.isEmpty
                })
                .receive(on: DispatchQueue.main)
                .assign(to: &$isRSSFeedTitleValid)
            
            Publishers.Zip($isRSSFeedURLValid, $isRSSFeedTitleValid)
                .compactMap { isRSSFeedURLValid, isRSSFeedTitleValid in
                    return isRSSFeedURLValid && isRSSFeedTitleValid
                }
                .assign(to: &$isCreatedObjectValid)
            
            $isCreatedObjectValid.sink { [weak self] isCreatedObjectValid in
                
                guard let self else {
                    return
                }
                
                self.newRSSFeedOpacityLevel = isCreatedObjectValid ? 1.0 : 0.5
                
                if isCreatedObjectValid {
                    self.createdRSSFeed = RSSSource(title: self.rssFeedTitle, url: self.rssFeedURL)
                }
            }
            .store(in: &bag)
        }
        
        public func createNewObjectButtonTapped() {
            
            guard let newRSSFeed: RSSSource = createdRSSFeed else {
                return
            }
            self.storageInteractor.store(item: newRSSFeed)
            self.coordinator?.handle(Action.cancel(self))
        }
        
        public func createNewSelectedObjectButtonTapped() {
            
            guard let newRSSFeed: RSSSource = selectedRSSFeed else {
                return
            }
            self.storageInteractor.store(item: newRSSFeed)
            self.coordinator?.handle(Action.cancel(self))
        }
    }
    
    final class ViewStates: ObservableObject {
        
        @Published var rssFeedURLViewState: RawViewState
        @Published var rssFeedTitleViewState: RawViewState
        @Published var startAnimations: Bool
        
        init(rssFeedURLViewState: RawViewState = .full,
             rssFeedTitleViewState: RawViewState = .glance,
             startAnimations: Bool = false) {
            
            self.rssFeedURLViewState = rssFeedURLViewState
            self.rssFeedTitleViewState = rssFeedTitleViewState
            self.startAnimations = startAnimations
        }
    }
}
