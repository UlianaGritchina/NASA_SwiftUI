//
//  ApodEntity.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

struct ApodEntity: Decodable {
    let copyright: String
    let date: String
    let explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl, title, url
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }
}
