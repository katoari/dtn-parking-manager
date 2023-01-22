//
//  HomeView.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 11/21/22.
//

import SwiftUI

struct HomeView : View{
    @StateObject var dataModel : DataViewModel
    @StateObject var navigationState = NaviagationStateManager()
    @StateObject var validation = FormValidation()
    @State private var tag = true
    
    init(dataService: DataSubscription) {
       _dataModel = StateObject(wrappedValue: DataViewModel(dataService: dataService))
    }
    
    
    var body: some View{
        
        if #available(iOS 16.0, *) {
            NavigationStack {
                TabView {
                    ParkingSlotView()
                        .tabItem({
                            Label(Views.slots, systemImage: Icons.parkingSign)
                        })
                        .onAppear(){
                            tag = true
                        }
                    OccupantsView()
                        .tabItem({
                            Label(Views.occupants, systemImage: Icons.employees)
                        })
                        .onAppear(){
                            tag = false
                        }
                }
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(
                    Color.theme_color,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .edgesIgnoringSafeArea(.all)
                .accentColor(Color.theme_color)
                .navigationTitle(tag ? Views.slots : Views.occupants)

            }
            .environmentObject(dataModel)
            .environmentObject(navigationState)
            .environmentObject(validation)

            
        }
        else {
            NavigationView{
                TabView {
                    ParkingSlotView()
                        .tabItem({
                            Label(Views.slots, systemImage: Icons.parkingSign)
                        })
                        .onAppear(){
                            tag = true
                        }
                    OccupantsView()
                        .tabItem({
                            Label(Views.occupants, systemImage: Icons.employees)
                        })
                        .onAppear(){
                            tag = false
                        }
                }
                .navigationViewStyle(.stack)
                .background(Color.theme_color)
                .edgesIgnoringSafeArea(.all)
                .accentColor(Color.theme_color)
                .navigationTitle(tag ? Views.slots : Views.occupants)

            }
            .environmentObject(dataModel)
            .environmentObject(navigationState)
            .environmentObject(validation)
        }

        
    }
    
    
}
struct HomeView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        HomeView(dataService: dataService)
            .environmentObject(DataViewModel(dataService: dataService))
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
        
    }
}
