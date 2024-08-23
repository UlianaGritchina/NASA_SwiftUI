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
                    Label("APOD", systemImage: "moon.stars.circle")
                }
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "sparkles")
                }
            FavoritesView()
                .tabItem {
                    Label("Favourites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
