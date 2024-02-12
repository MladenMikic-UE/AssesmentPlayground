//
//  Bundle+Ext.swift
//  Shared
//
//  Created by Mladen Mikic on 07.02.2024.
//

import Foundation

public extension Bundle {
    
    static var assesmentPlayground: Bundle? { Bundle(identifier: "com.unseenesxcellence.assesmentPlayground") }
    static var movemedical: Bundle? { Bundle(identifier: "com.unseenesxcellence.Movemedical") }
    static var endava: Bundle? { Bundle(identifier: "com.unseenesxcellence.Endava") }
    
    static var storagePath: String {
        
        if let assesmentPlayground: Bundle = Self.assesmentPlayground, Bundle.main == assesmentPlayground {
            return "assesments"
        } else if let movemedical: Bundle = Self.movemedical, Bundle.main == movemedical {
            return "appointments"
        } else if let endava: Bundle = Self.endava, Bundle.main == endava {
            return "rssFeeds"
        } else {
            return "empty"
        }
    }
}
