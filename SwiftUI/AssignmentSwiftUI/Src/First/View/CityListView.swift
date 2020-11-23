//
//  CityListView.swift
//  AssignmentSwiftUI
//
//  Created by Quân Đinh on 10.11.20.
//

import SwiftUI
import SwiftUIRefresh

struct CityListView: View {
    @ObservedObject var fetcher = CitiesFetcher()
    @State private var presentAddCity = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var refreshing = false
    @State private var showingSheet = false
    @State private var currentSelectedIndex = -1
    
    var body: some View {
        NavigationView {
            List(fetcher.citiesWeather.indices, id: \.self) { index in
                NavigationLink(destination: CityDetailView(index: index,
                                                           fetcher: fetcher)
                ) {
                    CityRowView(city: fetcher.citiesWeather[index])
                }.onLongPressGesture {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    currentSelectedIndex = index
                    showingSheet = true
                }
                /// on SwiftUI currently, gestures action on Navigation link only work on visible content areas
                /// which mean spacers will trigger the normal tap behaviour from navigation link.
                /// In this case long press gesture only work when hold on the texts in CityRowView
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: Button("Add") {
                presentAddCity = true
            }.sheet(isPresented: $presentAddCity, content: {
                AddCityView(presented: $presentAddCity,
                            fetcher: fetcher,
                            showError: $showError,
                            errorMessage: $errorMessage)
            }))
            .pullToRefresh(isShowing: $refreshing) {
                self.fetcher.load {
                    self.refreshing = false
                }
            }
        }.actionSheet(isPresented: $showingSheet) { () -> ActionSheet in
            let cancel = ActionSheet.Button.cancel {
                showingSheet = false
            }
            let delete = ActionSheet.Button.destructive(Text("Delete")) {
                self.fetcher.deleteElement(at: currentSelectedIndex)
            }
            return ActionSheet(title: Text("Delete this city"),
                               message: Text("Are you sure?"),
                               buttons: [cancel, delete])
        }.alert(isPresented: $showError, content: {
            let confirmButton = Alert.Button.cancel(Text("Ok")) {
                showError = false
            }
            return Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: confirmButton
            )
        })
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
