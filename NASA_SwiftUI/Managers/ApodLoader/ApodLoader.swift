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
    private let apodMapper = ApodMapper()
    
    private init() { }
    
    // MARK: Private methods
    
    private func buildURL(by parameters: ApodLoaderParameters? = nil) -> URL? {
        guard let parameters else { return URL(string: baseURL) }
        var urlString = baseURL
        if let date = parameters.date {
            urlString = baseURL + "&date=\(date.dateToString())"
        }
        if let count = parameters.count {
            urlString = baseURL + "&count=\(count)"
        }
        return URL(string: urlString)
    }
    
    // MARK: Public methods
    
    func loadImageData(from stringUrl: String) async throws -> Data? {
        guard let url = URL(string: stringUrl) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func loadApod(with parameters: ApodLoaderParameters? = nil) async throws -> Apod {
        guard let url = buildURL(by: parameters) else { throw NetworkError.badURL }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let apodEntity = try? JSONDecoder().decode(ApodNetworkEntity.self, from: data) else {
            throw NetworkError.noData
        }
        
        let apod = apodMapper.map(entity: apodEntity)
        
        return apod
    }
    
    func loadApods(count: Int)  async throws -> [Apod] {
        let params = ApodLoaderParameters(count: count)
        guard let url = buildURL(by: params) else { throw NetworkError.badURL }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let apodEntitys = try? JSONDecoder().decode([ApodNetworkEntity].self, from: data) else {
            throw NetworkError.noData
        }
        
        return apodEntitys.compactMap({ apodMapper.map(entity: $0) })
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
