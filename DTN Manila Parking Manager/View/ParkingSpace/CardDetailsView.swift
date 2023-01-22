//
//  CardDropdownView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/24/22.
//

import SwiftUI

struct CardDetailsView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @State var slot : Slot
    @State var selectionAppear : Bool = false
    @State var occupantDetailAppear : Bool = false
    @State var confirmAppear : Bool = false
    
    var body: some View {
        HStack {
            ZStack (alignment: dataModel.isParkingAvailable(slot.occupant) ? .center : .top){
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(dataModel.isParkingAvailable(slot.occupant) ? Color.available_color : Color.empty_color)
                VStack (alignment: .center){
                    isAvailableButton(status: slot.occupant)
                    occupantDetails()
                }
            }
        }
    }
}



struct CardDetailsView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        CardDetailsView(slot: Slot.defaultSlot)
            .environmentObject(DataViewModel(dataService: dataService))
    }
}
