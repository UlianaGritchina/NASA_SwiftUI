//
//  ApodViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

@MainActor final class ApodViewModel: ObservableObject {
    
    // MARK: Constants
    
    private let apodLoader = ApodLoader.shared
    
    // MARK: Published
    
    @Published private(set) var apod: Apod?
    
    init() {
        fetchApod()
    }
    
    var apodDateString: String {
        apod?.date ?? ""
    }
    
    // MARK: Private methos
    
    private func fetchApod() {
        Task {
            do {
                apod = try await apodLoader.loadApod()
            }
        }
    }
}
