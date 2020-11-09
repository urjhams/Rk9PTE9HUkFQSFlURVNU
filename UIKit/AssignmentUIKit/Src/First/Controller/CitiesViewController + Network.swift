//
//  CitiesViewController + Network.swift
//  AssignmentUIKit
//
//  Created by Quân Đinh on 09.11.20.
//

import Foundation

extension CitiesViewController {
    internal func loadWeather(of city: String, success: @escaping (Data)->Void) {
        let key = API.secrectKey
        let url = API.weatherByCityName + "?q=\(city)&appid=\(key)"
        
        Network.shared.sendPostRequest(to: url) { [weak self] in
            switch $0 {
            case .failure(let error):
                switch error {
                case .httpSeverSideError(_, statusCode: _):
                    self?.showNotificationAlert("Error",
                                                withContent: "City name not found, please try again")
                default:
                    self?.showNotificationAlert("Error",
                                                withContent: error.localizedDescription)
                }
            case .success(let data):
                success(data)
            }
        }
    }
    
    internal func loadCities(success: @escaping (Data)->Void) {
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
        
        Network.shared.sendPostRequest(to: url) { [weak self] in
            switch $0 {
            case .failure(let error):
                self?.showNotificationAlert("Error",
                                            withContent: error.localizedDescription)
            case .success(let data):
                success(data)
            }
        }
    }
}
