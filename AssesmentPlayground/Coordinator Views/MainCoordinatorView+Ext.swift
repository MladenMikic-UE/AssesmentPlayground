//
//  MainCoordinatorView+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI
import SwiftUICoordinator
import Combine

public extension MainCoordinatorView {
    
    class ViewState: ObservableObject {
        
        @Published var leftButtonProgress: CGFloat = 0
        @Published var rightButtonProgress: CGFloat = 0
        @Published var startAnimations: Bool = true
        
        public init(leftButtonProgress: CGFloat = 0, 
                    rightButtonProgress: CGFloat = 0,
                    startAnimations: Bool = true) {
            self.leftButtonProgress = leftButtonProgress
            self.rightButtonProgress = rightButtonProgress
            self.startAnimations = startAnimations
        }
    }
    
    enum ViewContentState {
        /// The first state is loading. Content is being loaded from the server or storage
        case loading
        /// There is no content.
        case empty
        /// There is some content.
        case filled
    }
    
    @MainActor class ViewModel<R: Routing>: ObservableObject {
        
        var coordinator: R?
        
        @Published var viewContentState: MainCoordinatorView.ViewContentState
        @Published var storageInteractor: StorageInteractor
        private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
        
        // MARK: - Init.
        public init(viewContentState: MainCoordinatorView.ViewContentState = .loading,
                    storageInteractor: StorageInteractor,
                    coordinator: R? = nil) {
            
            self.viewContentState = viewContentState
            self.storageInteractor = storageInteractor
            self.coordinator = coordinator
            
            self.storageInteractor.localStorage.$items
                .receive(on: RunLoop.main)
                .sink {[weak self] items in
                                    
                    guard let self else {
                        return
                    }
                    var newViewContentState: MainCoordinatorView.ViewContentState
                    
                    if self.storageInteractor.loadProcess == .didStart {
                        newViewContentState = .loading
                    } else {
                        newViewContentState = items.isEmpty ? .empty : .filled
                    }
                    
                    withAnimation {
                        self.viewContentState = newViewContentState
                    }
            }.store(in: &bag)
        }
        
        func didTapAddNewObject() {
            withAnimation {
                coordinator?.handle(MainAction.addNewObject)
            }
        }
    }
}
