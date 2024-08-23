//
//  CoreDataManager.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 23.08.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    
    var savedApods: [ApodEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: "Apods")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            } else {
                print("Successfully loading Core Data")
            }
        }
    }
    
    private func fetchApods() {
        let request = NSFetchRequest<ApodEntity>(entityName: "ApodEntity")
        do {
            savedApods = try container.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func getApods() -> [Apod] {
        var apods: [Apod] = []
        fetchApods()
        apods = savedApods.compactMap({
            var media: ApodMediaType = .image
            if let mediaTypeData = $0.mediaType,
               let mediaType = try? JSONDecoder().decode(ApodMediaType.self, from: mediaTypeData) {
                
                media = mediaType
            }
            return Apod(
                id: $0.id ?? "",
                title: $0.title ?? "",
                copyright: $0.copyright ?? "",
                explanation: $0.explanation ?? "", 
                date: $0.date ?? "",
                imageURL: URL(string: $0.imageURL ?? ""),
                mediaType: media
            )
        })
        
        return apods.reversed()
    }
    
    func addApod(apod: Apod) {
        let newApod = ApodEntity(context: container.viewContext)
        newApod.id = apod.id
        newApod.title = apod.title
        newApod.copyright = apod.copyright
        newApod.explanation = apod.explanation
        newApod.date = apod.date
        
        if let mediaTypeData = try? JSONEncoder().encode(apod.mediaType) {
            newApod.mediaType = mediaTypeData
        }
        newApod.imageURL = apod.imageURL?.absoluteString
        saveData()
    }
    
    func deleteApod(apod: Apod) {
        var apodForDelete = ApodEntity()
        if let findApod = savedApods.first(where: { $0.id == apod.id }) {
            apodForDelete = findApod
        }
        container.viewContext.delete(apodForDelete)
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving \(error)")
        }
    }
}
