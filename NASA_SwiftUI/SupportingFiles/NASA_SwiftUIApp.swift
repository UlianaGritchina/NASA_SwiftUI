//
//  NASA_SwiftUIApp.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 12.03.2024.
//

import SwiftUI

@main
struct NASA_SwiftUIApp: App {

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)
        }
    }
}
