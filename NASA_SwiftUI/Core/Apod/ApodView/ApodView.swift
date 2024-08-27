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
            ZStack(alignment: .top) {
                ImageBackground()
                ScrollView(showsIndicators: false) {
                    if viewModel.apod == nil {
                        ProgressView()
                    } else {
                        mainContent
                    }
                }
                .animation(.default, value: viewModel.isLoading)
                blackout
                if viewModel.isShowCalendar {
                    calendarView
                }
            }
            .navigationTitle("APOD")
            .onAppear { viewModel.setIsFavorite() }
            .fullScreenCover(isPresented: $viewModel.isOpenGoogleTranslate) {
                WebBrowserView(url: viewModel.googleTranslateURL)
            }
            .animation(.smooth, value: viewModel.isShowCalendar)
        }
        .navigationViewStyle(.stack)//test
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
            
            if viewModel.apod?.mediaType == .image {
                apodImageView
            } else {
                if let url = viewModel.apod?.imageURL?.absoluteString {
                    WebBrowserView(url: url, showsBrowserComponents: false)
                }
            }
            
            apodInfo
        }
        .padding(.horizontal, 16)
        .padding(.bottom)
    }
    
    private var dateView: some View {
        HStack(spacing: .zero) {
            Text("Astronomy picture of day: ")
                .font(.system(size: 15, design: .monospaced))
            Spacer()
            Button(viewModel.selectedDateString) {
                viewModel.showCalendar()
            }
            .buttonStyle(.bordered)
            .foregroundStyle(Color.white)
        }
        .overlay {
            if viewModel.isLoadingDate {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.secondaryGray)
                    .transition(.opacity)
            }
        }
        .animation(.default, value: viewModel.isLoadingDate)
    }
    
    @ViewBuilder private var apodImageView: some View {
        if let imageData = viewModel.apod?.imageData {
            VStack(alignment: .leading) {
                ImageView(imageData: imageData)
                HStack {
                    copyrightView
                    Spacer()
                    favoriteButton
                }
            }
        } else {
            imagePlaceholder
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
    
    private var favoriteButton: some View {
        Button(action: { viewModel.addToFavorite() }) {
            Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
        }
    }
    
    @ViewBuilder private var copyrightView: some View {
        if let copyright = viewModel.apod?.copyright {
            HStack(spacing: 3) {
                Image(systemName: "c.circle")
                Text(copyright)
            }
            .font(.system(size: 14, design: .rounded))
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
    
    private var calendarView: some View {
        VStack {
            HStack {
                if viewModel.isShowBackToTodayButton {
                    Button("Today") { viewModel.resetDate() }
                        .font(.headline)
                }
                Spacer()
                closeCalendarButton
            }
            DatePicker(
                selection: $viewModel.tempSelectedDate,
                in: ...viewModel.actualApodDate,
                displayedComponents: .date
            ) {
                Text("Astronomy picture of day: ")
            }
            .datePickerStyle(.graphical)
            Button(action: { viewModel.findApod() }) {
                Text("Find")
                    .font(.headline)
                    .padding(.horizontal, 52)
                    .padding(.vertical, 9)
                    .background(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
    
    private var closeCalendarButton: some View {
        Button(action: { viewModel.closeCalendar() })  {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(8)
                .background(.white)
                .clipShape(.circle)
        }
    }
    
    private var blackout: some View {
        Rectangle()
            .foregroundStyle(Color.black)
            .ignoresSafeArea()
            .opacity(viewModel.isShowCalendar ? 0.5 : 0)
            .onTapGesture { viewModel.closeCalendar()}
    }
}
