//
//  CityRowView.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI

struct CityRowView: View {
    var city: CityWeather
    
    var body: some View {
        HStack {
            Text(city.name)
            Spacer()
            Text("\(Int(city.main.temp.fromKevinToCelsius()))" + "ºC")
        }
    }
}

