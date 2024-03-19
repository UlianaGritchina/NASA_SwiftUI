//
//  ApodLoader.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

final class ApodLoader {
    
    enum NetworkError: Error {
        case badURL
        case noData
    }
    
    // MARK: Constants
    
    static let shared = ApodLoader()
    
    private let apiKey = "j927yMuuumpGvzeDtYe5YUsObO9FzOEnNhp0FnZX"
    private let baseURL = "https://api.nasa.gov/planetary/apod?api_key=j927yMuuumpGvzeDtYe5YUsObO9FzOEnNhp0FnZX"
    
    private let dateFormatter = DateFormatManager.shared
    
    private init() { }
    
    // MARK: Private methods
    
    private func buildURL(by parameters: ApodLoaderParameters? = nil) -> URL? {
        guard let parameters else { return URL(string: baseURL) }
        var urlString = baseURL
        if let date = parameters.date {
            urlString = baseURL + "&date=\(dateFormatter.dateToString(date))"
        }
        
        return URL(string: urlString)
    }
    
    private func mapApod(from apodEntity: ApodEntity) -> Apod {
        Apod(
            title: apodEntity.title,
            copyright: apodEntity.copyright,
            explanation: apodEntity.explanation,
            date: apodEntity.date,
            imageURL: getContentURL(apodEntity: apodEntity),
            mediaType: mapMediaType(type: apodEntity.mediaType)
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
    
    private func getContentURL(apodEntity: ApodEntity) -> URL? {
        if let hdurlString = apodEntity.hdurl {
            return URL(string: hdurlString)
        } else {
            return URL(string: apodEntity.url)
        }
    }
    
    func loadImageData(from stringUrl: String) async throws -> Data? {
        guard let url = URL(string: stringUrl) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    // MARK: Public methods
    
    func loadApod(with parameters: ApodLoaderParameters? = nil) async throws -> Apod {
        guard let url = buildURL(by: parameters) else { throw NetworkError.badURL }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let apodEntity = try? JSONDecoder().decode(ApodEntity.self, from: data) else {
            throw NetworkError.noData
        }
        
        let apod = mapApod(from: apodEntity)
        
        return apod
    }
    
    func loadActualApodDate() async throws -> String? {
        guard let url = buildURL() else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let apodDate = try? JSONDecoder().decode(ApodDate.self, from: data) else {
            throw NetworkError.noData
        }
        return apodDate.date
    }
}
