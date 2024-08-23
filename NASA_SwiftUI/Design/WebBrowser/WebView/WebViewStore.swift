//
//  WebViewStore.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import SwiftUI
import Combine
import WebKit

@dynamicMemberLookup
public class WebViewStore: ObservableObject {
    @Published public var webView: WKWebView {
        didSet {
            setupObservers()
        }
    }
    
    public init(webView: WKWebView = WKWebView()) {
        self.webView = webView
        setupObservers()
    }
    
    private func setupObservers() {
        func subscriber<Value>(for keyPath: KeyPath<WKWebView, Value>) -> NSKeyValueObservation {
            return webView.observe(keyPath, options: [.prior]) { _, change in
                if change.isPrior {
                    self.objectWillChange.send()
                }
            }
        }
        
        observers = [
            subscriber(for: \.title),
            subscriber(for: \.url),
            subscriber(for: \.isLoading),
            subscriber(for: \.estimatedProgress),
            subscriber(for: \.hasOnlySecureContent),
            subscriber(for: \.serverTrust),
            subscriber(for: \.canGoBack),
            subscriber(for: \.canGoForward),
        ]
        
    }
    
    private var observers: [NSKeyValueObservation] = []
    
    public subscript<T>(dynamicMember keyPath: KeyPath<WKWebView, T>) -> T {
        webView[keyPath: keyPath]
    }
}
