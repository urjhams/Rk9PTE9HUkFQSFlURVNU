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
                TextField("City name (e.g: London)", text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }.padding()
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presented = false
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            presented = false
            fetcher.addNewCity(cityName) { error in
                errorMessage = error
                showError = true
            }
        }.disabled(cityName == "")
    }
}
