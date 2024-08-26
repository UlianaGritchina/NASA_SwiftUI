//
//  ApodDetailView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import SwiftUI

struct ApodDetailView: View {
    @StateObject private var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    init(apod: Apod) {
        let vm = ViewModel(apod: apod)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ImageBackground()
                contentView
            }
            .navigationTitle(viewModel.apod.date)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {  dismissButton }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ApodDetailView(
        apod: Apod(
            title: "Title",
            copyright: "Uliana",
            explanation: "explanation",
            date: "fasdfas",
            imageURL: nil,
            mediaType: .image
        )
    )
}

extension ApodDetailView {
    
    private var dismissButton: some View {
        Button(action: { dismiss() }, label: {
            Image(systemName: "xmark")
        })
        .font(.title3)
    }
    
    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                if viewModel.apod.mediaType == .image {
                    apodImageView
                } else {
                    if let url = viewModel.apod.imageURL?.absoluteString {
                        WebBrowserView(url: url, showsBrowserComponents: false)
                    }
                }
                
                apodInfo
            }
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.isOpenGoogleTranslate) {
            WebBrowserView(url: viewModel.googleTranslateURL)
        }
    }
    
    @ViewBuilder private var apodImageView: some View {
        if let imageData = viewModel.apod.imageData {
            VStack(alignment: .leading) {
                ImageView(imageData: imageData)
                copyrightView
            }
        } else {
            imagePlaceholder
        }
    }
    
    @ViewBuilder private var copyrightView: some View {
        if let copyright = viewModel.apod.copyright {
            HStack(spacing: 3) {
                Image(systemName: "c.circle")
                Text(copyright)
            }
            .font(.system(size: 14, design: .rounded))
        }
    }
    
    private var imagePlaceholder: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height / 3)
            .opacity(0)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .overlay { ProgressView() }
    }
    
    private var apodInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.apod.title)
                .font(.title2)
            
            Text(viewModel.apod.explanation)
            
            Button("Open in Google Translate") {
                viewModel.openGoogleTranslate()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
