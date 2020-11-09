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
                self?.showNotificationAlert("Error", withContent: error.localizedDescription)
            case .success(let data):
                success(data)
            }
        }
    }
}
