//
//  FavoritesView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import SwiftUI

extension FavoritesView {
    @MainActor final class ViewModel: ObservableObject {
        
        private let coreDataManager = CoreDataManager.shared
        
        @Published var apods: [Apod] = []
        
        func fetchApods() {
            apods = coreDataManager.getApods()
        }
    }
}

struct FavoritesView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ImageBackground()
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 25) {
                        ForEach(viewModel.apods) { apod in
                            ApodRow(apod: apod)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.fetchApods()
            }
        }
    }
}

#Preview {
    FavoritesView()
}
