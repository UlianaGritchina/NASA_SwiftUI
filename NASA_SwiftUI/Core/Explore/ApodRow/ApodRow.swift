//
//  ApodRow.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 19.03.2024.
//

import SwiftUI

struct ApodRow: View {
    private let coreDataManager = CoreDataManager.shared
    let apod: Apod
    var body: some View {
        VStack(alignment: .leading) {
            
            NetworkImage(url: apod.imageURL)
            
            HStack(alignment: .top) {
                Text(apod.title)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button(action: {
                    coreDataManager.addApod(apod: apod)
                }) {
                    Image(systemName: "star")
                }
            }
            Text(apod.date)
                .foregroundStyle(Color.gray)
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.7))
        .cornerRadius(10)
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
