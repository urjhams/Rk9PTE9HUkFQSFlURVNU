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
            }.navigationBarItems(trailing: Button("Add") {
                presentAddCity = true
            }.sheet(isPresented: $presentAddCity, content: {
                AddCityView(presented: $presentAddCity, fetcher: fetcher)
            }))
        }
    }
}


struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
