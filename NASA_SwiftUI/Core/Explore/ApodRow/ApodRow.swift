//
//  ApodRow.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import SwiftUI

struct ApodRow: View {
    @StateObject private var viewModel: ViewModel
    
    init(apod: Apod) {
        let vm = ViewModel(apod: apod)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Button(action: { viewModel.showApodDetail() }) {
            VStack(alignment: .leading) {
                
                if viewModel.apod.mediaType == .image {
                    NetworkImage(url: viewModel.apod.imageURL)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
                        }
                } else {
                    if let url = viewModel.apod.imageURL?.absoluteString {
                        WebBrowserView(url: url, showsBrowserComponents: false)
                            .frame(maxHeight: 400)
                    }
                }
                
                HStack(alignment: .top) {
                    Text(viewModel.apod.title)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button(action: { viewModel.addToFavorite() }) {
                        Image(systemName: viewModel.favoriteButtonImageName)
                    }
                }
                .padding(.horizontal, 5)
                Text(viewModel.apod.date)
                    .foregroundStyle(Color.gray)
                    .padding(.horizontal, 5)
            }
            .padding(.bottom, 5)
            .background(.ultraThinMaterial.opacity(0.7))
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .sheet(isPresented: $viewModel.isShowApodDetail) {
            ApodDetailView(apod: viewModel.apod)
        }
    }
}

#Preview {
    ApodRow(apod: Apod(
        title: "lalal",
        copyright: "aksfjl",
        explanation: "lakjfk",
        date: "asdf",
        imageURL: nil,
        mediaType: .image
    ))
}
