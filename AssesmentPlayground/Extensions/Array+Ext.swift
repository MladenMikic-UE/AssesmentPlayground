//
//  Array+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        
        guard let index: Int = firstIndex(of: object) else {
            return
        }
        remove(at: index)
    }
    
    func removeDuplicates() -> [Element] {
        
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
