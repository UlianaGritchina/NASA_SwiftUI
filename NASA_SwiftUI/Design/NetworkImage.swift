//
//  NetworkImage.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import SwiftUI

struct NetworkImage: View {
    @State private var imageData: Data?
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        VStack {
            if let imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .opacity(0)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .overlay { ProgressView() }
            }
        }
        .onAppear {
            loadImage(url)
        }
    }
    
    private func loadImage(_ url: URL?) {
        guard let url = url?.absoluteString else { return }
        Task {
            do {
                imageData = try await ApodLoader.shared.loadImageData(from: url)
            }
        }
    }
}

#Preview {
    NetworkImage(
        url: URL(string: "https://apod.nasa.gov/apod/image/1402/pleiades_lane_960.jpg")
    )
}
