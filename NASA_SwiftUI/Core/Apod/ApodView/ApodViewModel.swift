//
//  ApodViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import Foundation

@MainActor final class ApodViewModel: ObservableObject {
    
    // MARK: Constants
    
    private let apodLoader = ApodLoader.shared
    private let userDefaultManager = UserDefaultsManager.shared
    
    // MARK: Published
    
    @Published private(set) var apod: Apod?
    @Published private(set) var googleTranslateURL: String = ""
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingDate = false
    @Published private(set) var selectedDate: Date = Date()
    @Published private(set)var isShowCalendar = false
    
    @Published var tempSelectedDate: Date = Date()
    @Published var actualApodDate: Date = Date()
    @Published var isOpenGoogleTranslate = false
    
    init() {
        setApod()
    }
    
    var apodDateString: String {
        apod?.date ?? ""
    }
    
    var apodDate: Date? {
        apodDateString.toDate()
    }
    
    var selectedDateString: String {
        selectedDate.dateToString(format: "d MMM YYY")
    }
    
    var isShowBackToTodayButton: Bool {
        selectedDate != actualApodDate
    }
    
    // MARK: Private methods
    
    private func setApod() {
        apod = userDefaultManager.getApod()
        isLoadingDate = true
        Task {
            do {
                let actualDate = try await apodLoader.loadActualApodDate()
                if let date = actualDate?.toDate() {
                    actualApodDate = date
                    selectedDate = date
                    isLoadingDate = false
                }
                if actualDate != apod?.date {
                    fetchApod()
                }
            }
        }
    }
    
    private func fetchApod() {
        isLoading = true
        Task {
            do {
                apod = try await apodLoader.loadApod()
                guard let apod else { return }
                isLoading = false
                if let imageURL = apod.imageURL?.absoluteString {
                    self.apod?.imageData = try await apodLoader.loadImageData(from: imageURL)
                    userDefaultManager.saveApod(self.apod!)
                }
            }
        }
    }
    
    // MARK: Public methods
    
    func showCalendar() {
        isShowCalendar = true
    }
    
    func closeCalendar() {
        tempSelectedDate = selectedDate
        isShowCalendar = false
    }
    
    func resetDate() {
        selectedDate = actualApodDate
        tempSelectedDate = actualApodDate
        closeCalendar()
        findApod()
    }
    
    func findApod() {
        selectedDate = tempSelectedDate
        isShowCalendar = false
        if selectedDate == actualApodDate {
            apod = userDefaultManager.getApod()
        } else {
            let params = ApodLoaderParameters(date: selectedDate)
            Task {
                do {
                    isLoading = true
                    apod = try await apodLoader.loadApod(with: params)
                    isLoading = false
                    if let imageURL = apod?.imageURL?.absoluteString {
                        apod?.imageData = try await apodLoader.loadImageData(from: imageURL)
                    }
                }
            }
        }
    }
    
    func openGoogleTranslate() {
        guard let title = apod?.title, let explanation = apod?.explanation else { return }
        let text = "\(title). \(explanation)"
        var stringForUrl = text.replacingOccurrences(
            of: " ",
            with: "%20",
            options: NSString.CompareOptions.literal,
            range: nil
        )
        
        stringForUrl = stringForUrl.applyingTransform(.stripDiacritics, reverse: false)!
        stringForUrl.removeAll(where: { $0 == "¿" || $0 == "¡"})
        let urlString = "https://translate.google.com/?sl=auto&tl=ru&text=\(stringForUrl)&op=translate"
        
        googleTranslateURL = urlString
        isOpenGoogleTranslate = true
    }
}
