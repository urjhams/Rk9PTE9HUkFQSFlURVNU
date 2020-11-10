//
//  AddCityView.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI

struct AddCityView: View {
    @Binding var presented: Bool
    @ObservedObject var fetcher: CitiesFetcher
    @State var cityName = ""
    @Binding var showError: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("City name (e.g: London)",
                          text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }.padding()
            .navigationBarItems(
                leading: Button("Cancel"){ presented = false },
                trailing: Button("Save") {
                    presented = false
                    fetcher.addNewCity(cityName) { error in
                        self.errorMessage = error
                        self.showError = true
                    }
                }.disabled(cityName == "")
            )
        }
    }
}
