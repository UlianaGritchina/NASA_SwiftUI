//
//  Apod.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

struct Apod: Codable {
    let title: String
    let copyright: String?
    let explanation: String
    let date: String
    let imageURL: URL?
    var imageData: Data?
}
