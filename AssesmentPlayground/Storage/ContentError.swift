//
//  ContentError.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation

public enum ContentError: Error {
    
    case duplicate(item: UniqueCodableClass)
    case addItemsFailed
    case deleteItemFailedNotFound
}
