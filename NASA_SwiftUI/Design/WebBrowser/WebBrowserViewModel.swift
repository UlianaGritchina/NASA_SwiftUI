//
//  WebBrowserViewModel.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import Foundation

extension WebBrowserView {
    @MainActor final class ViewModel: ObservableObject {
        
        var stringURL: String
        
        @Published var isOpenShareView = false
        @Published var downloadAmount: Float = 0.5
        @Published var progress = 0.0
        
        
        init(stringURL: String) {
            self.stringURL = stringURL
        }
        
        var isShowingProgressBar: Bool {
            progress < 1
        }
        
        func openShareView() {
            isOpenShareView = true
        }
        
    }
}
