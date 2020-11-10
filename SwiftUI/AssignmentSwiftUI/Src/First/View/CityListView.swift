//
//  CityListView.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var fetcher = CitiesFetcher()
    @State var presentAddCity = false
    
    var body: some View {
        NavigationView {
            List(fetcher.citiesWeather, id: \.id) { item in
                NavigationLink(destination: CityDetailView()) {
                    CityRowView(city: item)
                }
            }.navigationBarItems(trailing: Button("+") {
                self.presentAddCity = true
            }.sheet(isPresented: $presentAddCity, content: {
                AddCityView(presented: $presentAddCity)
            }))
        }
    }
}


struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}

public class CitiesFetcher: ObservableObject {
    @Published var citiesWeather = [CityWeather]()
    
    init() { load() }
    
    func load() {
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
                break
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(ListCityWeather.self, from: data)
                    if let list = decoded.list { self.citiesWeather = list }
                } catch {
                    break
                }
            }
        }
    }
}
