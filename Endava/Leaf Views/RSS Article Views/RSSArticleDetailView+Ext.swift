//
//  RSSArticleDetailView+Ext.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import SwiftUI
import Combine
import SwiftUICoordinator

extension RSSArticleDetailView {
    
    @MainActor
    final class ViewModel<R: Routing>: ObservableObject {
 
        var coordinator: R?
        @Published private(set) var storageInteractor: StorageInteractor
        public let model: RSSArticle
        private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
       
        // MARK: - Init.
        init(model: RSSArticle,
             storageInteractor: StorageInteractor,
             coordinator: R?) {
            self.model = model
            self.storageInteractor = storageInteractor
            self.coordinator = coordinator
        }
  
        public func openModelWebpage() {
            
            guard let eURL: URL = URL(string: model.link) else {
                return
            }
            if UserDefaults.openAllWebPagesOutsideOfTheApp {
                UIApplication.shared.open(eURL)
            } else {
                coordinator?.handle(MainAction.openWebpage(url: eURL))
            }
        }
    }
    
    final class ViewStates: ObservableObject {
        
        @Published var startAnimations: Bool
        
        // MARK: - Init.
        init(startAnimations: Bool = false) {
            
            self.startAnimations = startAnimations
        }
    }
}
