//
//  Apod.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

enum ApodMediaType: String, Codable {
    case image
    case video
}

struct Apod: Codable {
    let title: String
    let copyright: String?
    let explanation: String
    let date: String
    let imageURL: URL?
    let mediaType: ApodMediaType
    var imageData: Data?
}
