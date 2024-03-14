//
//  SpecialNavBar.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 14.03.2024.
//

import SwiftUI

struct SpecialNavBar: ViewModifier {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-Bold", size: 20)!
        ]
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
