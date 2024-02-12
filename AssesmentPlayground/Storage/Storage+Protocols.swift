//
//  Storage+Protocols.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import Combine

public class UniqueCodableClass: UniqueCodable {
    
    public static func == (lhs: UniqueCodableClass, rhs: UniqueCodableClass) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public protocol ItemsProtocol: AddProtocol, DeleteProtcol {
    var items: Container { get }
    var itemsPublished: Published<Container> { get }
    var itemsPublisher: Published<Container>.Publisher { get }
}

public protocol ContentProtocol {
    associatedtype Container
    associatedtype SingleItem
}

public protocol AddProtocol: ContentProtocol {

    func add(itemContainer: Container)
    func add(item: SingleItem)
}

public protocol DeleteProtcol: ContentProtocol {
    
    func delete(itemContainer: Container)
    func delete(item: SingleItem)
}
 
public protocol UniqueCodable: Codable, Identifiable, Equatable, Hashable {}


// TODO: Add later.
public protocol EditProtcol {}

// TODO: Add later.
public protocol SortProtcol {}
// create, read, update, and delete
