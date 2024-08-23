//
//  ApodLoaderParameters.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

struct ApodLoaderParameters {
    let date: Date?
    let startDate: Date?
    let endDate: Date?
    let count: Int?
    
    init(
        date: Date? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        count: Int? = nil
    ) {
        self.date = date
        self.startDate = startDate
        self.endDate = endDate
        self.count = count
    }
}
