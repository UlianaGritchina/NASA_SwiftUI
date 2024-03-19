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
                Image("back")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.3)
                ScrollView {
                    if !viewModel.apods.isEmpty {
                        apodsList
                    }
                }
            }
            .navigationTitle("Explore")
            .sheet(isPresented: $viewModel.isShowApodView) {
                ApodDetailView(apod: viewModel.selectedApod)
            }
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
                Button(action: {viewModel.selectApod(apod)}, label: {
                    ApodRow(apod: apod)
                })
            }
            ProgressView()
                .onAppear {
                    viewModel.loadMore()
                }
        }
    }
}
