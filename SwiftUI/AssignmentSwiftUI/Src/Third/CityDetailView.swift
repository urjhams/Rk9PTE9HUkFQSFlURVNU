//
//  CityDetailView.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI

struct CityDetailView: View {
    var index: Int
    @ObservedObject var fetcher: CitiesFetcher
    
    var body: some View {
        ScrollView {
            mainContentView
        }.onAppear(perform: {
            updateDetail()
        })
    }
    
    @ViewBuilder private var mainContentView: some View {
        if index < fetcher.citiesWeather.count {
            Text("\(fetcher.citiesWeather[index].name)")
                .font(.system(size: 24, weight: .bold, design: .default))
            
            Text("\(fetcher.citiesWeather[index].weather.first?.description ?? "")")
                .font(.system(size: 18))
            
            Text("\(Int(fetcher.citiesWeather[index].main.temp.fromKevinToCelsius()))" + "ºC")
                .font(.system(size: 40, weight: .bold, design: .default))
            
            Text("humidity: \(fetcher.citiesWeather[index].main.humidity)" + "%")
                .font(.system(size: 18))
            
            Spacer()
        }
    }
}

extension CityDetailView {
    internal func updateDetail() {
        let id = fetcher.citiesWeather[index].id
        let key = API.secrectKey
        let url = API.weatherByCityName + "?id=\(id)&appid=\(key)"

        Network.shared.sendPostRequest(to: url) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(CityWeather.self, from: data)
                    fetcher.setElement(at: index, with: model)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
