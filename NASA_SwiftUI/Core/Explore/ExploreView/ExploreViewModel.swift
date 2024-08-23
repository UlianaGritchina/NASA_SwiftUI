//
//  ExploreView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import Foundation

extension ExploreView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        private let apodLoader = ApodLoader.shared
        
        // MARK: Published
        
        @Published private(set) var apods: [Apod] = []
        @Published private(set) var isLoading = false
        init() {
            fetchApods()
        }
        
        // MARK: Private methods
        
        private func fetchApods() {
            isLoading = true
            Task {
                do {
                    apods = try await apodLoader.loadApods(count: 10)
                    isLoading = false
                }
            }
        }
        
        // MARK: Public methods
        
        func loadMore() {
            Task {
                do {
                    let newApods = try await apodLoader.loadApods(count: 10)
                    apods += newApods
                }
            }
        }
    }
}
