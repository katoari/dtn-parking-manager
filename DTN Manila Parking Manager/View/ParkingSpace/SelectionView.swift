//
//  SheetView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/29/22.
//

import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @State private var selection: String?
    @Binding var selectionListAppear : Bool
    @State var slot : Slot
    
    var body: some View {
        NavigationView {
            VStack {
                List (dataModel.filterOccupants(by: slot), selection: $selection) { occupant in
                    Text(occupant.name)
                }
                .searchable(text: $dataModel.searchedOccupant, placement: .navigationBarDrawer(displayMode: .always))
                .onChange(of: selection) { selected in
                    if let selected = selected {
                        //print(selected)
                        let getDate = dataModel.timeKeeper.createCurrentDateTime()
                        dataModel.updateSlotOccupant(floor: slot.parkingSpaceID, slotNumber: slot.id, newValue: selected)
                        dataModel.updateSlotDate(floor: slot.parkingSpaceID, slotNumber: slot.id, newValue: getDate)
                        selectionListAppear = false

                        
                    }
                }
                .listStyle(.inset)
            }
            .toolbar {
                ToolbarItem (placement: .cancellationAction){
                    Button("Cancel") {
                        selectionListAppear = false
                    }
                }
                ToolbarItem (placement: .principal){
                    Text("Select an Employee")
                        .font(.headline)
                        .bold()
                }
            }

        }
    }
}
struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(
            selectionListAppear: .constant(true),
            slot: Slot(
                id: "",
                occupant: "",
                date: "",
                time: "",
                type: "",
                parkingSpaceID: ""
            ))
        .environmentObject(DataViewModel())
    }
}
