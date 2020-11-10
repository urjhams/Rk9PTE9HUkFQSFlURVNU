//
//  CitiesFetcher.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI

public class CitiesFetcher: ObservableObject {
    @Published var citiesWeather = [CityWeather]() {
        didSet {
            let data = citiesWeather.map { return CityData(from: $0) }
            AppData.savedCities = data
        }
    }
    
    init() { load {} }
    
    public func load(_ done: @escaping ()->Void) {
        guard AppData.savedCities.count > 0 else { return }
        let list = AppData.savedCities
        let ids = list.map { return $0.id }
        let key = API.secrectKey
        var url = API.weatherByCities + "?id="
        
        for index in 0..<ids.count {
            let id = ids[index]
            
            // append the ids after the first one with "," before
            url = url + ((index == 0) ? "\(id)" : ",\(id)")
        }
        
        // final url
        url = url + "&appid=\(key)"
        Network.shared.sendPostRequest(to: url) { result in
            switch result {
            case .failure(_):
                done()
            case .success(let data):
                done()
                do {
                    let decoded = try JSONDecoder().decode(ListCityWeather.self, from: data)
                    if let list = decoded.list { self.citiesWeather = list }
                } catch {
                    break
                }
            }
        }
    }
    
    public func addNewCity(_ name: String) {
        let key = API.secrectKey
        let url = API.weatherByCityName + "?q=\(name)&appid=\(key)"
        
        Network.shared.sendPostRequest(to: url) { result in
            switch result {
            case .failure(_):
                break
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(CityWeather.self, from: data)
                    for index in 0..<self.citiesWeather.count {
                        // if city is already added, just reload the data
                        if model.id == self.citiesWeather[index].id {
                            self.citiesWeather[index] = model
                            return
                        }
                    }
                    self.citiesWeather.append(model)
                } catch {
                    break
                }
            }
        }
    }
    
    public func setElement(at index: Int, with newElement: CityWeather) {
        citiesWeather[index] = newElement
    }
    
    public func deleteElement(at index: Int) {
        citiesWeather.remove(at: index)
    }
}
