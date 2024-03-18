//
//  UserDefaultsManager.swift
//  NASA_SwiftUI
//
//  Created by Ульяна Гритчина on 15.03.2024.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: Constants
    
    static let shared = UserDefaultsManager()
    
    private let apodKey = "actual_apod_Key"
    
    private init() { }
    
    // MARK: Public methods
    
    func saveApod(_ apod: Apod) {
        if let encodedData = try? JSONEncoder().encode(apod) {
            UserDefaults.standard.set(encodedData, forKey: apodKey)
        }
    }
    
    func getApod() -> Apod? {
        guard
            let data = UserDefaults.standard.data(forKey: apodKey),
            let apod = try? JSONDecoder().decode(Apod.self, from: data)
        else { 
            return nil
        }
        return apod
    }
}
