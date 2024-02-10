//
//  Bundle+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 07.02.2024.
//

import Foundation

extension Bundle {
    
    static var assesmentPlayground: Bundle? { Bundle(identifier: "com.unseenesxcellence.assesmentPlayground") }
    static var movemedical: Bundle? { Bundle(identifier: "com.unseenesxcellence.Movemedical") }
    static var endava: Bundle? { Bundle(identifier: "com.unseenesxcellence.Endava") }
    
    static var storagePath: String {
        if let assesmentPlayground = Self.assesmentPlayground, Bundle.main == assesmentPlayground {
            return "assesments"
        } else if let movemedical = Self.movemedical, Bundle.main == movemedical {
            return "appointments"
        } else if let endava = Self.endava, Bundle.main == endava {
            return "rssFeeds"
        } else {
            return "empty"
        }
    }
}
