//
//  AddCityView.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI

struct AddCityView: View {
    @Binding var presented: Bool
    @State var cityName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("City name (e.g: London)",
                          text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }.padding()
            .navigationBarItems(leading: Button("Cancel"){ self.presented = false },
                                trailing: Button("Save") { self.presented = false })
        }
    }
}
