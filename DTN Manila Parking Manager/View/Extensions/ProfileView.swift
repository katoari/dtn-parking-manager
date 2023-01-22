//
//  EmployeeDetailsView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/22/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @EnvironmentObject var navigationManager : NaviagationStateManager
    @State var showAlert = false
    let occupant : Occupant
    var slot : Slot?
    
    
    var body: some View {
        AdaptiveView {
            ZStack (alignment: .top){
                Color
                    .details_background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack (alignment: .center){
                        NameInitials(name: occupant.name, height: 110, width: 120)
                        Text(occupant.name)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.all)
                    .padding(.top)
                    VStack (alignment: .leading){
                        DetailsContainer(label: Labels.phone.lowercased(), detail: occupant.phone)
                        if occupant.vehicle != Conditions.bike{
                            DetailsContainer(label: Labels.plateNo.lowercased(), detail: occupant.plateNo)
                        }
                        DetailsContainer(label: Labels.vehicle.lowercased(), detail: occupant.vehicle)
                        appearDate()
                    }
                    Spacer()
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Labels.alertTitle),
                    message: Text(Labels.alertMessage),
                    dismissButton: .default(Text(Buttons.ok)))
            }
        }
    }
    
}




struct EmployeeDetailsView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        ProfileView(occupant: Occupant.defaultOccupant)
            .environmentObject(DataViewModel(dataService: dataService))
            .environmentObject(NaviagationStateManager())
    }
}
