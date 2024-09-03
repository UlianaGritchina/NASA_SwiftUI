//
//  FavoritesViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import Foundation

protocol ApodsRepository {
    func fetchApods() async throws -> [Apod]?
    func save(apod: Apod) async throws
    func delete(apod: Apod) async throws
}

final class CoreDataApodRepository: ApodsRepository {
    private let coreDataManager = CoreDataManager.shared
    
    func fetchApods() -> [Apod]? {
        coreDataManager.getApods()
    }
    
    func save(apod: Apod) {
        coreDataManager.addApod(apod: apod)
    }
    
    func delete(apod: Apod) {
        coreDataManager.deleteApod(apod: apod)
    }
}

extension FavoritesView {
    @MainActor final class ViewModel: ObservableObject {
        
        let apodRepository: ApodsRepository
        
        init(apodRepository: ApodsRepository) {
            self.apodRepository = apodRepository
        }
        
        @Published var apods: [Apod] = []
        
        func fetchApods() {
            Task {
                do {
                    let fetchedApods = try await apodRepository.fetchApods()
                    guard let fetchedApods else { return }
                    apods = fetchedApods
                } catch {
                    print(error)
                }
            }
        }
    }
}
