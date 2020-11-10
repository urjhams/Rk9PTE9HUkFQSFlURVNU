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
            List(fetcher.citiesWeather.indices, id: \.self) { index in
                NavigationLink(destination: CityDetailView(index: index, fetcher: fetcher)) {
                    CityRowView(city: fetcher.citiesWeather[index])
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: Button("Add") {
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
