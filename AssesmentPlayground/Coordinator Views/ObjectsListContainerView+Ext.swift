//
//  ObjectsListContainerView+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import SwiftUICoordinator
import Combine

extension ObjectsListContainerView {
    
    @MainActor
    class ViewModel<R: Routing, T: UniqueCodableClass>: ObservableObject {

        var coordinator: R?
        @Published var storageInteractor: StorageInteractor
        @Published var models: [T]
        private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
        
        // MARK: - Init.
        init(coordinator: R? = nil,
             storageInteractor: StorageInteractor,
             models: [T] = []) {
            self.coordinator = coordinator
            self.storageInteractor = storageInteractor
            self.models = models
            
            self.storageInteractor.localStorage.$items
                .receive(on: RunLoop.main)
                .sink { [weak self] items in
                
                guard let self else {
                    return
                }
                
                let appointments: [T] = items.compactMap { $0 as? T }
                self.models = appointments
            }
            .store(in: &bag)
        }
        
        func editObjectButtonTapped(with model: UniqueCodableClass) {
            coordinator?.handle(MainAction.edit(object: model))
        }
        
        func addObjectButtonTapped() {
            coordinator?.handle(MainAction.addNewObject)
        }
    }
}
