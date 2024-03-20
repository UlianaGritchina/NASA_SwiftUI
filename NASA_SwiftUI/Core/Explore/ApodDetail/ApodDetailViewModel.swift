//
//  ApodDetailViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 20.03.2024.
//

import Foundation

extension ApodDetailView {
    
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        private let apodLoader = ApodLoader.shared
        
        @Published var apod: Apod
        
        // MARK: Published
        
        @Published var isOpenGoogleTranslate = false
        @Published private(set) var googleTranslateURL: String = ""
        
        init(apod: Apod) {
            self.apod = apod
            fetchApodImage()
        }
        
        // MARK: Private methods
        
        private func fetchApodImage() {
            if apod.imageData == nil {
                guard let url = apod.imageURL?.absoluteString else { return }
                Task {
                    apod.imageData = try await apodLoader.loadImageData(from: url)
                }
            }
        }
        
        func openGoogleTranslate() {
            
            let text = "\(apod.title). \(apod.explanation)"
            var stringForUrl = text.replacingOccurrences(
                of: " ",
                with: "%20",
                options: NSString.CompareOptions.literal,
                range: nil
            )
            
            stringForUrl = stringForUrl.applyingTransform(.stripDiacritics, reverse: false)!
            stringForUrl.removeAll(where: { $0 == "¿" || $0 == "¡"})
            let urlString = "https://translate.google.com/?sl=auto&tl=ru&text=\(stringForUrl)&op=translate"
            
            googleTranslateURL = urlString
            isOpenGoogleTranslate = true
        }
    }
}
