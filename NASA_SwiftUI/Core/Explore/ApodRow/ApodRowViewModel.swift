//
//  ApodRowViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import Foundation

extension ApodRow {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        private let coreDataManager = CoreDataManager.shared
        
        // MARK: Published
        
        @Published private(set) var isFavorite = false
        
        @Published var isShowApodDetail = false
        
        let apod: Apod
        
        init(apod: Apod) {
            self.apod = apod
            setIsFavorite()
        }
        
        // MARK: Computered Properties
        
        var favoriteButtonImageName: String {
            isFavorite ? "star.fill" : "star"
        }
        
        // MARK: Private Methods
        
        private func setIsFavorite() {
            let favoriteApods = coreDataManager.getApods()
            isFavorite = favoriteApods.contains(where: { $0.date == apod.date })
        }
        
        // MARK: Public Methods
        
        func addToFavorite() {
            if isFavorite {
                coreDataManager.deleteApod(apod: apod)
                isFavorite = false
            } else {
                coreDataManager.addApod(apod: apod)
                isFavorite = true
            }
        }
        
        func showApodDetail() {
            isShowApodDetail.toggle()
        }
    }
}
