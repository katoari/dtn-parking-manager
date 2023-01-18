//
//  OccupantsView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/8/23.
//

import SwiftUI

struct OccupantsView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @EnvironmentObject var navigationManager : NaviagationStateManager
    @EnvironmentObject var validation : FormValidation
    
    @State private var showSheet  = false
    @State private var showAlert  = false
    @State private var toDelete : Occupant?
    
    
    var body: some View {
        NavigationSplitView (columnVisibility: .constant(.doubleColumn)){
            List (selection: $navigationManager.selectionState){
                Section {
                    ForEach(dataModel.searchableOccupants) { occupant in
                        Text(occupant.name)
                            .tag(NavigationState.profileOccupant(occupant))
                    }
                    .onDelete { index in
                        showAlert = true
                        index.sorted(by: > ).forEach { i in
                            toDelete = dataModel.occupants.remove(at: i)

                        }
                    }
                }
            }
            .confirmationDialog(
                Buttons.dialog1,
                isPresented: $showAlert,
                titleVisibility: .visible) {
                    Button(Buttons.yes){
                        if let toDelete = toDelete {
                            dataModel.deleteOccupant(occupant: toDelete)
                        }
                    }.keyboardShortcut(.defaultAction)
                    Button(Buttons.no, role: .cancel, action: {
                        dataModel.reload()
                    })
            }
            .refreshable(action: {dataModel.reload()})
            .toolbar{
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: Buttons.add)
                }
            }
            .sheet(isPresented: $showSheet, content: {
                AddOccupantView(showSheet: $showSheet)
                
            })
            .searchable(text: $dataModel.searchedOccupant, placement: .navigationBarDrawer(displayMode: .always))
            .listStyle(.inset)
        } detail: {
            
            if let state = navigationManager.selectionState{
                
                switch state {
                case .profileOccupant(let occupant):
                    ProfileView(occupant: occupant)
                case .editOccupant(let occupant):
                    EditOccupantView(occupant: occupant)
                }
            }
            else{
                Text(Labels.defaultTitle)
            }
                        
        }
        .navigationSplitViewStyle(.balanced)
        
    }

    
}
struct OccupantsView_Previews: PreviewProvider {
    static var previews: some View {
        OccupantsView()
            .environmentObject(DataViewModel())
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
    }
}
