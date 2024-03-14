//
//  ApodView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import SwiftUI

struct ApodView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Astronomy picture of day: 11.12.2001")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15, design: .monospaced))
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("APOD")
            .specialNavBar()
        }
    }
}

#Preview {
    ApodView()
}

struct SpecialNavBar: ViewModifier {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "NASA", size: 40)!]
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func specialNavBar() -> some View {
        self.modifier(SpecialNavBar())
    }
}
