//
//  ImageBackground.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 20.03.2024.
//

import SwiftUI

struct ImageBackground: View {
    var body: some View {
        Image("back")
            .resizable()
            .ignoresSafeArea()
            .overlay {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(Color.black)
                    .opacity(0.5)
            }
    }
}

#Preview {
    ImageBackground()
}
