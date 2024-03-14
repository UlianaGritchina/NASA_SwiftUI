//
//  MainTabView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 12.03.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ApodView()
                .tabItem {
                    Label("APODd", systemImage: "moon.stars.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
