//
//  WebVeiwRepresentable.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import SwiftUI
import WebKit

public struct WebViewRepresentable: View, UIViewRepresentable {
    public let webView: WKWebView

    public init(webView: WKWebView) {
        self.webView = webView
    }

    public func makeUIView(context: UIViewRepresentableContext<WebViewRepresentable>) -> WKWebView {
        webView
    }

    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebViewRepresentable>) {
    }
}
