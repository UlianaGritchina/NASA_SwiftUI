//
//  StringExtension.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
