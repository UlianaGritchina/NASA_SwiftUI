//
//  FavoritesViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import Foundation

extension FavoritesView {
    @MainActor final class ViewModel: ObservableObject {
        
        private let coreDataManager = CoreDataManager.shared
        
        @Published var apods: [Apod] = []
        
        func fetchApods() {
            apods = coreDataManager.getApods()
        }
    }
}
