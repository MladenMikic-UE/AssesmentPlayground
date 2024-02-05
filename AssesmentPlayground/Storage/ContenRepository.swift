//
//  ContenRepository.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import Combine

public class ContenRepository: Identifiable, ItemsProtocol, ObservableObject {
    
    // MARK: - Identifiable.
    
    /// Unique identifier provided on init.
    public let id: Int
    
    // MARK: - ItemsProtocol.
    
    public typealias SingleItem = UniqueCodableClass
    public typealias Container = [UniqueCodableClass]
    /// - Warning: Do not add or remove `items` directly.
    /// - Note: Reading is Thread-safe.
    @Published private(set) public var items: [SingleItem]
    @Published public var error: ContentError?
    
    public var itemsPublished: Published<[SingleItem]> { _items }
    
    public var itemsPublisher: Published<[SingleItem]>.Publisher { $items }
    
    /// Used for manipulating the `items` array.
    private var itemQueue: DispatchQueue = DispatchQueue(label: "ContenRepository.\(Int.random(in: 0...100))")

    // MARK: - Init.

    required public init(items: [SingleItem] = []) {
        self.id = Int.random(in: 0...Int.max)
        self.items = items
    }
    
    public static func empty() -> Self { Self.init(items: []) }
    
    // MARK: - Create.
    
    /// - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    /// - Features:
    ///     - Duplicate check (ordered merging).
    public func add(itemContainer: Container) {
        
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                return
            }

            var merged = self.items
            merged.append(contentsOf: itemContainer)
            if let uniqueMerged = NSOrderedSet(array: merged).array as? [UniqueCodableClass] {

                let uniqueArray = uniqueMerged.removeDuplicates()
                
                DispatchQueue.main.async { [weak self] in
                    self?.items.removeAll()
                    self?.items.append(contentsOf: uniqueArray)
                }
            } else {
                assertionFailure("Array conversion failed.")
                self.handle(error: .addItemsFailed)
            }
        }
    }
    
    /// - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    /// - Features:
    ///     - Duplicate check (ordered merging).
    public func add(item: SingleItem) {
        
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                return
            }

            if self.items.firstIndex(of: item) == nil {
                
                DispatchQueue.main.async { [weak self] in
                    self?.items.append(item)
                }
            } else {
                self.handle(error: .duplicate(item: item))
            }
        }
    }
    
    // - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    /// - Features:
    ///     - Duplicate check (ordered merging).
    public func add(item: SingleItem,  completion: @escaping () -> ()) {
        
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                completion()
                return
            }

            if self.items.firstIndex(of: item) != nil {
                
                DispatchQueue.main.async { [weak self] in
                    self?.items.append(item)
                    completion()
                }
            } else {
                self.handle(error: .duplicate(item: item))
                completion()
            }
        }
    }
    
    
    // MARK: - Update.
    /// - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    public func update(item: SingleItem) {
        
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                return
            }

            if let updateItemIndex: Int = self.items.firstIndex(of: item)  {
                
                DispatchQueue.main.async { [weak self] in
                    self?.items[updateItemIndex] = item
                }
            } else {
                self.add(item: item)
            }
        }
    }
    
    // MARK: - Delete.
    /// - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    public func delete(itemContainer: Container) {
      
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                return
            }

            assertionFailure("TODO: Implement later.")
        }
    }
    
    /// - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    public func delete(item: SingleItem) {
        
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                return
            }

            if let deleteItemIndex: Int = self.items.firstIndex(of: item)  {
                
                DispatchQueue.main.async { [weak self] in
                    self?.items.remove(at: deleteItemIndex)
                }
            } else {
                self.handle(error: .deleteItemFailedNotFound)
            }
        }
    }
    
    /// - Note: Thread-safe. Performed on `itemQueue` serial `DispatchQueue`.
    public func delete(item: SingleItem, completion: @escaping () -> ()) {
        
        // Logging...
        
        self.itemQueue.async { [weak self] in
            
            guard let self else {
                completion()
                return
            }

            if let deleteItemIndex: Int = self.items.firstIndex(of: item)  {
                
                DispatchQueue.main.async { [weak self] in
                    self?.items.remove(at: deleteItemIndex)
                    completion()
                }
            } else {
                self.handle(error: .deleteItemFailedNotFound)
                completion()
            }
        }
    }

    private func handle(error: ContentError) {
        
        // Logging...
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self else {
                return
            }
            
            self.error = error
        }
    }
    
    // MARK: - Codable.
    private enum CodingKeys: CodingKey {
        case id
        case items
    }
}
