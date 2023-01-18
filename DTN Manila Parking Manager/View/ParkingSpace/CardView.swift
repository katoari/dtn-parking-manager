//
//  CardView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/21/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @State var slots : [Slot]
    @State private var tempParking: String = ""
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    
    
    var body: some View {
        
        AdaptiveView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]) {
                ForEach(slots, id: \.self) { slot in
                    ZStack(){
                        Rectangle()
                            .frame(height: 160)
                            .foregroundColor(.white)
                        VStack(spacing: 0){
                            Text("\(General.slot) \(slot.id)")
                                .frame(maxWidth: .infinity, maxHeight:30, alignment: .center)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .background(.gray)
                                .border(.black.opacity(0.7))
                            CardDetailsView(slot: slot)

                        }
                    }.onAppear(){
                        self.tempParking = slot.parkingSpaceID
                    }
                }
                .onChange(of: dataModel.parkingFloors) { floor in
                    // slots, temparking, newValue
                    if let index = floor.firstIndex(where: {$0.title == self.tempParking}) {
                        slots = floor[index].slots!
                    }
                }
            }
        }
    }
    
    
    struct CardView_Previews: PreviewProvider {
        static var previews: some View {
            CardView(slots: [
                Slot(
                    id: "",
                    occupant: "",
                    date: "",
                    time: "",
                    type: "",
                    parkingSpaceID: ""
                )])
                .environmentObject(DataViewModel())
        }
    }
}
