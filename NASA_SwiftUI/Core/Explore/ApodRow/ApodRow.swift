//
//  ApodRow.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import SwiftUI

struct ApodRow: View {
    let apod: Apod
    var body: some View {
        VStack(alignment: .leading) {
            NetworkImage(url: apod.imageURL)
            Text(apod.title)
                .font(.title3)
                .foregroundStyle(.white)
            Text(apod.date)
                .foregroundStyle(Color.gray)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    ApodRow(apod: Apod(
        title: "lalal",
        copyright: "aksfjl",
        explanation: "lakjfk",
        date: "asdf",
        imageURL: nil,
        mediaType: .image
    ))
}
