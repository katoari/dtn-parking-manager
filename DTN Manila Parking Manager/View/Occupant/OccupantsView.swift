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
    @State private var showDialog  = false
    @State private var toDelete : Occupant = Occupant.defaultOccupant
    
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView (columnVisibility: .constant(.doubleColumn)){
                List (selection: $navigationManager.selectionState){
                    Section {
                        ForEach(dataModel.searchableOccupants(type: dataModel.occupants)) { occupant in
                            NavigationLink(occupant.name, value: NavigationState.profileOccupant(occupant))
                        }
                        .onDelete { index in
                            index.sorted(by: > ).forEach { i in
                                toDelete = dataModel.occupants.remove(at: i)
                            }
                            let slot = dataModel.getSlot(by: toDelete)
                            if slot != nil {
                                showAlert = true
                            } else {
                                showDialog = true
                            }
                        }
                    }
                }
                .onAppear(){
                    validation.occupants = dataModel.occupants
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text(Labels.alertMessage),
                        message: Text(Labels.alertMessage),
                        dismissButton: .default(Text(Buttons.ok)))
                })
                .confirmationDialog(
                    Buttons.dialog1,
                    isPresented: $showDialog,
                    titleVisibility: .visible) {
                        Button(Buttons.yes){
                            dataModel.deleteOccupant(toDelete)
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
                        EditOccupantView()
                            .onAppear(){
                                DispatchQueue.main.async {
                                    validation.occupant = occupant
                                }
                                
                            }
                    }
                }
                else{
                    Text(Labels.defaultTitle)
                }
                
            }
            .navigationSplitViewStyle(.balanced)
        } else {
            // Fallback on earlier versions
        }
        
    }

    
}
struct OccupantsView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        OccupantsView()
            .environmentObject(DataViewModel(dataService: dataService))
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
    }
}
