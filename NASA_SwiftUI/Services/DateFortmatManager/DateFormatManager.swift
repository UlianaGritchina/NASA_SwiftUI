//
//  DateFormatManager.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 15.03.2024.
//

import Foundation

final class DateFormatManager {
    
    static let shared = DateFormatManager()
    
    private init() { }
    
    func dateToString(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func stringToDate(_ string: String, format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
}
