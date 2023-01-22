//
//  AddOccupantView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/12/23.
//

import SwiftUI

struct AddOccupantView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @EnvironmentObject var navigationManager : NaviagationStateManager
    @EnvironmentObject var validation : FormValidation
    @Binding var showSheet : Bool
    @State var showDialog : Bool = false
    @State var showErrors : Bool = false
    @FocusState var keyboardFocused: Bool
    
    var body: some View {
        NavigationView {
            AdaptiveView {
                VStack {
                    NameInitials(name: validation.occupant.name)
                    formBuilder()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                        }
                    }
                    Spacer()
                }
                .background(Color.details_background)
                .toolbar {
                    ToolbarItem (placement: .cancellationAction){
                        Button(Buttons.cancel) {
                            if validation.isNotDiscard() {
                                showDialog = true
                            } else {
                                showSheet = false
                            }
                        }
                    }
                    ToolbarItem (placement: .principal){
                        Text(Labels.addTitle)
                            .font(.headline)
                            .bold()
                    }
                    ToolbarItem (placement: .confirmationAction){
                        Button {
                            if !validation.validationComplete() {
                                let newOccupant = Occupant(
                                    id: validation.occupant.id,
                                    name: validation.occupant.name,
                                    phone:
                                        validation.occupant.phone,
                                    plateNo: validation.occupant.plateNo,
                                    vehicle: validation.occupant.vehicle)
                                
                                dataModel.addOccupant(occupant: newOccupant)
                                showSheet = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    navigationManager.goToProfile(to: newOccupant)
                                }
                            } else {
                                showErrors = true 
                            }
                            
                        } label: {
                            Text(Buttons.done)
                        }
                    }
                }
            }
            .onAppear(){
                validation.occupant = Occupant.defaultOccupant
            }
            .confirmationDialog(Buttons.dialog2,
                                isPresented: $showDialog,
                                titleVisibility: .visible
            ) {
                Button {
                    showSheet = false
                } label: {
                    Text(Buttons.discard)
                        .foregroundColor(.red)
                        
                }
                .foregroundColor(.red)
                Button(Buttons.keepEdit, role: .cancel){}
            }

        }
    }
}

struct AddOccupantView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        AddOccupantView(showSheet: .constant(true))
            .environmentObject(DataViewModel(dataService: dataService))
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
    }
}
