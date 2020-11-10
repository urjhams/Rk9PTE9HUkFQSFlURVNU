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
    
    init(from city: CityWeather) {
        name = city.name
        id = city.id
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
    
    struct Wrapper<T> : Codable where T : Codable {
        let wrapped : T
    }
    
    var wrappedValue: T {
        get {
            // Read saved JSON data from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return defaultValue }
            
            // Convert the JSON to the desire data type
            let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
            return value?.wrapped ?? defaultValue
        }
        set {
            do {
                // Convert newValue to JSON data
                let data = try JSONEncoder().encode(Wrapper(wrapped: newValue))
                
                // Set the JSON data to UserDefaults
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                debugPrint("cannot set wrapper")
            }
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
