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
                            if validation.isNotEmpty() {
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
                            let newOccupant = Occupant(
                                name: validation.occupant.name,
                                contactNo: validation.occupant.contactNo,
                                plateNo: validation.occupant.plateNo,
                                vehicle: validation.occupant.vehicle)
                            
                            dataModel.addOccupant(occupant: newOccupant)
                            showSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                navigationManager.goToProfile(to: newOccupant)
                            }
                            
                        } label: {
                            Text(Buttons.done)
                        }
                        .disabled(validation.isAddOccupantComplete())
                    }
                }
            }
            .onAppear(){
                validation.occupant = Occupant(name: "", contactNo: "", plateNo: "")
            }
            .onChange(of: validation.occupant) { newValue in
                print(validation.isNotEmpty())
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
    static var previews: some View {
        AddOccupantView(showSheet: .constant(true))
            .environmentObject(DataViewModel())
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
    }
}
