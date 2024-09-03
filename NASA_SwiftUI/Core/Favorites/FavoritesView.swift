//
//  FavoritesView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = ViewModel(apodRepository: CoreDataApodRepository())
    
    var body: some View {
        NavigationView {
            ZStack {
                ImageBackground()
                ScrollView(showsIndicators: false) {
                    if viewModel.apods.isEmpty {
                        Text("No Favourites yet")
                            .font(.title)
                            .padding(.top, 20)
                    } else {
                        VStack(spacing: 25) {
                            ForEach(viewModel.apods) { apod in
                                ApodRow(apod: apod)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
                .refreshable { viewModel.fetchApods() }
            }
            .navigationTitle("Favourites")
            .onAppear {
                viewModel.fetchApods()
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    FavoritesView()
}
