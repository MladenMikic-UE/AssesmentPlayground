//
//  StorageInteractor.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import Combine

final class StorageInteractor: ObservableObject {
    
    @Published private(set) var localStorage: AppointmentRepository
    @Published private(set) var diskStorageClient: DiskStorageClient?
    // Use the load process .finished to check if everything went correctly.
    @Published var loadProcess: DiskStorageProcess = .notStarted
    private var appointmentsStoragePath: String = "appointments"
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(localStorage: AppointmentRepository = .init(),
         diskStorageClient: DiskStorageClient? ) {
        
        self.localStorage = localStorage
        
        if let diskStorageClient {
            self.diskStorageClient = diskStorageClient
        } else {
            do {
                self.diskStorageClient = try DiskStorageClient()
            } catch let error {
                // TODO: Error handling.
                self.diskStorageClient = nil
            }
        }
        
        self.localStorage.$items.receive(on: RunLoop.main).sink { [weak self] items in
            
            self?.autoStore(type: Appointment.self)
            
        }.store(in: &bag)
        
        self.load(type: Appointment.self)
    }
    
    func store(item: UniqueCodableClass) {
        localStorage.add(item: item)
    }
    
    func remove(item: UniqueCodableClass) {
        localStorage.delete(item: item)
    }
    
    private func load<T: UniqueCodableClass>(type: T.Type) {
        
        update(loadProcess: .willStart)
        
        guard let diskStorageClient: DiskStorageClient = self.diskStorageClient else {
            return
        }
        
        update(loadProcess: .didStart)
        
        do {
            let items: [T] = try diskStorageClient.codableLocalStorage?.fetch(for: appointmentsStoragePath) ?? []
            update(loadProcess: .finished)
            self.localStorage.add(itemContainer: items)
        } catch let error {
            update(loadProcess: .failed(error: error))
        }
    }
    
    private func autoStore<T: UniqueCodableClass>(type: T.Type) {
        
        guard let diskStorageClient: DiskStorageClient = self.diskStorageClient else {
            return
        }
        
        let generalType: [T] = localStorage.items.compactMap { $0 as? T }
        
        
        do {
            try diskStorageClient.codableLocalStorage?.save(generalType, for: appointmentsStoragePath)
        } catch let error {
            print("\(#function) error: \(error.localizedDescription)")
            // TODO: Handle error.
        }
    }
    
    private func update(loadProcess: DiskStorageProcess) {
        
        DispatchQueue.main.async { [weak self] in
            self?.loadProcess = loadProcess
        }
    }
}
