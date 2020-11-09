//
//  AppData.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import Foundation

struct CityData: Codable, Equatable {
    var name: String = "none"
    var id: Int = -1
    
    init(from cityData: CityData) {
        name = cityData.name
        id = cityData.id
    }
    
    static func == (lhs: CityData, rhs: CityData) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.id == rhs.id
    }
}

@propertyWrapper
struct CodableUserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct AppData {
    private static var cityNameListKey = "CityNameList"
    
    @CodableUserDefault(AppData.cityNameListKey, defaultValue: [CityData]())
    public static var savedCities: [CityData]
    
    public static func removeCity(_ name: String) {
        if let index = AppData.savedCities.firstIndex(where: { $0.name == name }) {
            AppData.savedCities.remove(at: index)
        }
        UserDefaults.standard.synchronize()
    }
}
