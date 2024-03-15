//
//  ApodView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import SwiftUI

struct ApodView: View {
    @StateObject private var viewModel = ApodViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.apod == nil {
                    ProgressView()
                } else {
                    mainContent
                }
            }
            .navigationTitle("APOD")
            .fullScreenCover(isPresented: $viewModel.isOpenGoogleTranslate) {
                WebBrowserView(url: viewModel.googleTranslateURL)
            }
        }
    }
}

#Preview {
    ApodView()
}

extension ApodView {
    
    private var mainContent: some View {
        VStack(spacing: 10) {
            dateView
            if viewModel.isLoading {
                ProgressView()
            }
            apodImageView
            apodInfo
        }
        .padding(.horizontal, 16)
        .padding(.bottom)
    }
    
    private var dateView: some View {
        DatePicker(
            selection: $viewModel.selectedDate,
            in: ...viewModel.actualApodDate,
            displayedComponents: .date
        ) {
            Text("Astronomy picture of day: ")
        }
        .font(.system(size: 15, design: .monospaced))
        .overlay {
            if viewModel.isLoadingDate {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.secondaryGray)
                    .transition(.opacity)
            }
        }
        .animation(.default, value: viewModel.isLoadingDate)
        .onChange(of: viewModel.selectedDate) { _ in
            viewModel.findApod()
        }
    }
    
    @ViewBuilder private var apodImageView: some View {
        if let imageData = viewModel.apod?.imageData {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .cornerRadius(10)
                HStack(spacing: 3) {
                    Image(systemName: "c.circle")
                    Text(viewModel.apod?.copyright ?? "")
                }
                .font(.system(size: 14, design: .rounded))
            }
        }
    }
    
    private var apodInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.apod?.title ?? "")
                .font(.title2)
            
            Text(viewModel.apod?.explanation ?? "")
            
            Button("Open in Google Translate") {
                viewModel.openGoogleTranslate()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
