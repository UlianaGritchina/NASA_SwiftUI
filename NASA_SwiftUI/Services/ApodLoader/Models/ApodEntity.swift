//
//  ApodEntity.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

struct ApodEntity: Decodable {
    let date: String
    let explanation: String
    let hdurl: String?
    let copyright: String?
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdurl
        case copyright
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}
