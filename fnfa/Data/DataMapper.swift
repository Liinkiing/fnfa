//
// Created by Jbara Omar on 14/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//

import Foundation

enum DataMapperError: Error {
    case errorReadingFile, elementNotFound
}

class DataMapper {

    static let instance = DataMapper()
    let userDefaults = UserDefaults.standard
    let FAVORITES_KEY_USER = "favorites"

    private init() {
    }

    var events: [Event] {
        get {
            guard let filePath = Bundle.main.url(forResource: "events", withExtension: "json") else { return [] }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Event].self, from: data)
        }
    }

    var categories: [Category] {
        get {
            guard let filePath = Bundle.main.url(forResource: "categories", withExtension: "json") else {
                return []
            }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Category].self, from: data)
        }
    }

    var places: [Place] {
        get {
            guard let filePath = Bundle.main.url(forResource: "places", withExtension: "json") else {
                return []
            }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Place].self, from: data)
        }
    }

    func getSavedFavorites() -> [Event] {
        guard let data = userDefaults.data(forKey: FAVORITES_KEY_USER) else { return [] }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! [Event]
    }

    func save(favorites: [Event]) {
        let placeData = NSKeyedArchiver.archivedData(withRootObject: favorites)
        userDefaults.set(placeData, forKey: FAVORITES_KEY_USER)
    }

}
