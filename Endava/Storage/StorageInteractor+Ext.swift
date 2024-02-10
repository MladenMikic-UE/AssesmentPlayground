//
//  StorageInteractor+Ext.swift
//  Endava
//
//  Created by Mladen Mikic on 10.02.2024.
//

import Foundation

extension StorageInteractor {
    
    func loadSpecificDataModelType() {
        self.load(type: RSSSource.self)
    }
    
    func autoStore() {
        self.store(type: RSSSource.self)
    }
}
