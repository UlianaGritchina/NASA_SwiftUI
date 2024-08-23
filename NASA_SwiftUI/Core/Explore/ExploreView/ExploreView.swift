//
//  ExploreView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                ImageBackground()
                ScrollView {
                    if viewModel.isLoading {
                       Text("🛸")
                            .padding(.top, UIScreen.main.bounds.height / 3)
                    } else {
                        if !viewModel.apods.isEmpty {
                            apodsList
                        }
                    }
                }
            }
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}

extension ExploreView {
    
    @ViewBuilder private var apodsList: some View {
        LazyVStack(spacing: 25) {
            ForEach(viewModel.apods) { apod in
                ApodRow(apod: apod)
            }
            ProgressView()
                .onAppear { viewModel.loadMore() }
        }
    }
}
