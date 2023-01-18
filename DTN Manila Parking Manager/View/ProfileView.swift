//
//  EmployeeDetailsView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/22/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var navigationManager : NaviagationStateManager
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
                        DetailsContainer(label: Labels.phone.lowercased(), detail: occupant.contactNo)
                        if occupant.vehicle != Conditions.bike{
                            DetailsContainer(label: Labels.plateNo.lowercased(), detail: occupant.plateNo)
                        }
                        DetailsContainer(label: Labels.vehicle.lowercased(), detail: occupant.vehicle)
                        appearDate()
                    }
                    Spacer()
                }
                
            }
        }
    }
    
}




struct EmployeeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(occupant: Occupant(name: "", contactNo: "", plateNo: "", vehicle: ""))
            .environmentObject(DataViewModel())
            .environmentObject(NaviagationStateManager())
    }
}
