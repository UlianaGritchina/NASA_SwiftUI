//
//  NASA_SwiftUIApp.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 12.03.2024.
//

import SwiftUI

@main
struct NASA_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
