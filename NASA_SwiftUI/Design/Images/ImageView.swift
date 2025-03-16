//
//  ImageView.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 17.03.2024.
//

import SwiftUI

struct ImageView: View {
    let imageData: Data
    var body: some View {
        Image(uiImage: UIImage(data: imageData)!)
            .resizable()
            .frame(maxWidth: .infinity)
            .scaledToFit()
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.3)
                    .foregroundStyle(Color.white.opacity(0.5))
            }
    }
}

#Preview {
    ImageView(imageData: Data())
}
