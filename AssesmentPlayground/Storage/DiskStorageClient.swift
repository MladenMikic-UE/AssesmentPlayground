//
//  DiskStorageClient.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import StorageKit


public class DiskStorageClient: ObservableObject, Identifiable {

    // MARK: - Identifiable.
    public var id: Int
    /// Represents the `FileManager documentDirectory`.
    let storageURL: URL
    var localStorage: FileStorage! = nil
    var codableLocalStorage: CodableFileStorage! = nil
    /// Unique serial storage queue.
    let storageQueue: DispatchQueue = DispatchQueue(label: "\(DiskStorageClient.self).\(Int.random(in: 0...Int.max))")
    // Changed by subclass.
    /// Subscribe to receive non critical errors.
    @Published var nonCriticalError: Error! = nil

    
    // MARK: - Init.
    
    /// - WARNING: Dont call `init` from main-thread.
    public init() throws {
        
        // ARPLogger.shared.log("")
        
        self.id = Int.random(in: 0...Int.max)
        
        do {
            
            let documentsDirectoryURL: URL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            self.storageURL = documentsDirectoryURL
            
            // ARPLogger.shared.log("documentsDirectoryURL: \(documentsDirectoryURL)", type: .error, feature: .storage)
            
            self.localStorage = FileStorage(path: documentsDirectoryURL)
            self.codableLocalStorage = CodableFileStorage(storage: self.localStorage)
        } catch let error {
            
            // ARPLogger.shared.log("\(error.localizedDescription)", type: .error, feature: .storage)

            throw error
        }
    }
    
    func fileExists(atPath: String) -> Bool {
                
        return self.codableLocalStorage?.fileExists(atPath: atPath) ?? false
    }
}
