//
//  StorageInteractor.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import Combine

final public class StorageInteractor: ObservableObject {
    
    @Published private(set) var localStorage: ContenRepository
    @Published private(set) var diskStorageClient: DiskStorageClient?
    // Use the load process .finished to check if everything went correctly.
    @Published var loadProcess: DiskStorageProcess = .notStarted
    public let storagePath: String
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public init(localStorage: ContenRepository = .init(),
                diskStorageClient: DiskStorageClient?,
                storagePath: String) {
        
        self.localStorage = localStorage
        self.storagePath = storagePath
        
        if let diskStorageClient {
            self.diskStorageClient = diskStorageClient
        } else {
            do {
                self.diskStorageClient = try DiskStorageClient()
            } catch let error {
                // TODO: F1: Handle error.
                print("\(#function) error: \(error.localizedDescription)")
                self.diskStorageClient = nil
            }
        }
        
        self.localStorage.$items
            .receive(on: RunLoop.main).sink { [weak self] items in
            
            self?.autoStore()
            
        }.store(in: &bag)
        
        self.loadSpecificDataModelType()
    }
    
    func store(item: UniqueCodableClass) {
        print("\(#function) Store item: \(item).")
        localStorage.add(item: item)
    }
    
    func remove(item: UniqueCodableClass) {
        print("\(#function) Delete item: \(item).")
        localStorage.delete(item: item)
    }
    
    public func load<T: UniqueCodableClass>(type: T.Type) {
        
        update(loadProcess: .willStart)
        
        guard let diskStorageClient: DiskStorageClient = self.diskStorageClient else {
            print("\(#function) Storage loading FAILED.")
            return
        }
        
        update(loadProcess: .didStart)
        
        do {
            let items: [T] = try diskStorageClient.codableLocalStorage?.fetch(for: storagePath) ?? []
            update(loadProcess: .finished)
            print("\(#function) Storage loading SUCCESS. Items: \(items)")
            self.localStorage.add(itemContainer: items)
        } catch let error {
            print("\(#function) error: \(error.localizedDescription)")
            // TODO: F1: Handle error.
            update(loadProcess: .failed(error: error))
        }
    }
    
    public func store<T: UniqueCodableClass>(type: T.Type) {
        
        guard let diskStorageClient: DiskStorageClient = self.diskStorageClient else {
            print("\(#function) Storage storing FAILED.")
            return
        }
        
        let generalType: [T] = localStorage.items.compactMap { $0 as? T }
        
        do {
            try diskStorageClient.codableLocalStorage?.save(generalType, for: storagePath)
            print("\(#function) Storage storing SUCCESS.")
        } catch let error {
            // TODO: F1: Handle error.
            print("\(#function) error: \(error.localizedDescription)")
        }
    }
    
    private func update(loadProcess: DiskStorageProcess) {
        
        DispatchQueue.main.async { [weak self] in
            self?.loadProcess = loadProcess
        }
    }
}
