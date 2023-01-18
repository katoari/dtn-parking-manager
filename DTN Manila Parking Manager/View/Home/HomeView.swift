//
//  HomeView.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 11/21/22.
//

import SwiftUI

struct HomeView : View{
    @StateObject var dataModel = DataViewModel()
    @StateObject var navigationState = NaviagationStateManager()
    @StateObject var validation = FormValidation()
    
    @State private var tag = true
    
    
    var body: some View{
        
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
    
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataViewModel())
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
        
    }
}
