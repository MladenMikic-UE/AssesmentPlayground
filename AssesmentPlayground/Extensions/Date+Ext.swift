//
//  Date+Ext.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 04.02.2024.
//

import Foundation

extension Date {
    
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
