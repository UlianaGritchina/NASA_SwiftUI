//
//  ApodMapper.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 03.09.2024.
//

import Foundation

final class ApodMapper {
    
    func map(entity: ApodNetworkEntity) -> Apod {
        Apod(
            title: entity.title,
            copyright: entity.copyright,
            explanation: entity.explanation,
            date: entity.date,
            imageURL: URL(string: entity.url),
            mediaType: mapMediaType(type: entity.mediaType)
        )
    }
    
    private func mapMediaType(type: String) -> ApodMediaType {
        switch type {
        case ApodMediaType.image.rawValue:
            return ApodMediaType.image
        case ApodMediaType.video.rawValue:
            return  ApodMediaType.video
        default:
            return ApodMediaType.image
        }
    }
}
