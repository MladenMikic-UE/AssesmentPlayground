//
//  DiskStorageProcess.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation

enum DiskStorageProcess: Equatable {
    
    static func == (lhs: DiskStorageProcess, rhs: DiskStorageProcess) -> Bool {
        switch (lhs, rhs) {
        case (.notStarted, .notStarted): return true
        case (.willStart, .willStart): return true
        case (.didStart, .didStart): return true
        case (.finished, .finished): return true
        case (.failed, .failed): return true
        default: return false
        }
    }
    
    case notStarted
    case willStart
    case didStart
    case finished
    case failed(error: Error)
}
