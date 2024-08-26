//
//  WebBrowserView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import SwiftUI

struct WebBrowserView: View {
    @StateObject private var viewModel: ViewModel
    @StateObject var webViewStore = WebViewStore()
    @Environment(\.dismiss) private var dismiss

    init(url: String, showsBrowserComponents: Bool = true) {
        let vm = ViewModel(stringURL: url, showsBrowserComponents: showsBrowserComponents)
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        NavigationView {
            if viewModel.showsBrowserComponents {
                WebViewRepresentable(webView: webViewStore.webView)
                    .navigationTitle(webViewStore.title ?? "")
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $viewModel.isOpenShareView) {
                        ActivityView(activityItems: .constant([viewModel.stringURL]))
                    }
                    .toolbar {
                        dismissButton
                        reloadWebViewButton
                        bottomBar
                    }
                    .onChange(of: webViewStore.estimatedProgress, perform: { newValue in
                        viewModel.progress = newValue
                    })
                    .overlay(alignment: .top) { progressView }
                    .onAppear { loadWebView() }
                    .navigationViewStyle(.stack)
            } else {
                WebViewRepresentable(webView: webViewStore.webView)
                    .navigationTitle(webViewStore.title ?? "")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        if webViewStore.estimatedProgress == 0 {
                            loadWebView()
                        }
                    }
                    .navigationViewStyle(.stack)
            }
        }
    }

    @ViewBuilder private var progressView: some View {
        if viewModel.isShowingProgressBar {
            ProgressView(value: viewModel.progress, total: 1)
                .animation(.easeIn, value: viewModel.progress)
                .progressViewStyle(RectangleProgressViewStyle())
        }
    }

    private var dismissButton: some ToolbarContent {
        ToolbarItemGroup(placement: .cancellationAction) {
            Button("Закрыть", action: { dismiss() })
        }
    }

    private var reloadWebViewButton: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: {
                webViewStore.webView.reload()
            }) {
                Image(systemName: "arrow.clockwise")
            }
        }
    }

    private var bottomBar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack {
                webNavigationButtons
                Spacer()
                shareButton
                Spacer()
                goToSafariButton
            }
        }
    }

    private var webNavigationButtons: some View {
        HStack {
            Button(action: goWebViewBack) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            }
            .disabled(!webViewStore.canGoBack)

            Button(action: goWebViewForward) {
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            }
            .disabled(!webViewStore.canGoForward)
        }
    }

    @ViewBuilder private var shareButton: some View {
        if #available(iOS 16.0, *) {
            ShareLink(item: viewModel.stringURL) {
                Image(systemName: "square.and.arrow.up")
            }
            Spacer()
        } else {
            Button(action: {
                viewModel.openShareView()
            }) {
                Image(systemName: "square.and.arrow.up")
            }
            Spacer()
        }
    }

    private var goToSafariButton: some View {
        Button(action: { UIApplication.shared.open(URL(string: viewModel.stringURL)!)}) {
            Image(systemName: "safari")
                .imageScale(.large)
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
        }
    }

    private func goWebViewBack() {
        webViewStore.webView.goBack()
    }

    private func goWebViewForward() {
        webViewStore.webView.goForward()
    }

    private func loadWebView() {
        guard let url = URL(string: viewModel.stringURL) else { return }
        DispatchQueue.main.async {
            webViewStore.webView.load(URLRequest(url: url))
        }
    }
}

public struct RectangleProgressViewStyle: ProgressViewStyle {

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 4)
                .foregroundColor(.blue)
                .overlay(Color(
                    red: 0.863,
                    green: 0.863,
                    blue: 0.863,
                    opacity: 1
                ))

            Rectangle()
                .frame(
                    width: CGFloat(configuration.fractionCompleted ?? 0) + 1,
                    height: 4
                )
                .foregroundColor(.accentColor)

            ProgressView(configuration).tint(.accentColor)
        }
    }
}
