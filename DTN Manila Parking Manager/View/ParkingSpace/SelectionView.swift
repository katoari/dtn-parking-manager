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
                        print(selected)
                        let getDate = TimeKeeper.shared.createCurrentDateTime()
                        dataModel.freeUpOrOccupy(from: slot, newValue: selected)
                        dataModel.updateSlotDate(from: slot,  newValue: getDate)
                        selectionListAppear = false

                        
                    }
                }
                .listStyle(.inset)
            }
            .toolbar {
                ToolbarItem (placement: .cancellationAction){
                    Button(Buttons.cancel) {
                        selectionListAppear = false
                    }
                }
                ToolbarItem (placement: .principal){
                    Text(Labels.defaultTitle)
                        .font(.headline)
                        .bold()
                }
            }

        }
    }
}
struct SheetView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        SelectionView(
            selectionListAppear: .constant(true),
            slot: Slot.defaultSlot)
        .environmentObject(DataViewModel(dataService: dataService))
    }
}
