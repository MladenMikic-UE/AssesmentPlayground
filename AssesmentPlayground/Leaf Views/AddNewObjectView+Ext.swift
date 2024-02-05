//
//  AddNewObjectView+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import Foundation
import SwiftUICoordinator

extension AddNewObjectView {
    
    @MainActor
    final class ViewModel<R: Routing, T: UniqueCodableClass>: ObservableObject {
        
        @Published var storageInteractor: StorageInteractor
        @Published var oldModel: UniqueCodableClass? = nil
        var coordinator: R?
        
        init(storageInteractor: StorageInteractor, 
             oldModel: UniqueCodableClass? = nil,
             coordinator: R? = nil) {
            
            self.storageInteractor = storageInteractor
            self.oldModel = oldModel
            self.coordinator = coordinator
        }
        
        func closeButtonTapped() {
            self.coordinator?.handle(Action.cancel(self))
        }  
        
        func deleteButtonTapped() {
            
            if let oldModel: UniqueCodableClass {
                storageInteractor.remove(item: oldModel)
                self.coordinator?.handle(Action.done(oldModel))
            } else {
                self.coordinator?.handle(Action.done(self))
            }
        }
    }
}
