//
//  City.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import Foundation

struct ListCityWeather: Codable {
    var cnt: Int
    var list: [CityWeather]?
}

struct CityWeather: Codable {
    var coord: Coordinate      // always have
    var weather: [Weather]     // always have
    var base: String?
    var main: WeatherMain      // always have
    var visibility: Int         // always have
    var wind: WeatherWind      // always have
    var clouds: WeatherCloud   // always have
    var dt: TimeInterval       // always have
    var sys: WeatherSys        // always have
    var timezone: Int?
    var id: Int                 // always have
    var name: String            // always have
    var cod: Int?
}

struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct WeatherMain: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct WeatherWind: Codable {
    var speed: Double
    var deg: Int
}

struct WeatherCloud: Codable {
    var all: Int
}

struct WeatherSys: Codable {
    var type: Int?
    var id: Int?
    var country: String
    var sunrise: TimeInterval
    var sunset: TimeInterval
    var timezone: Int?
}
