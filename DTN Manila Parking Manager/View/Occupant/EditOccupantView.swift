//
//  EditOccupantView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/13/23.
//

import SwiftUI

struct EditOccupantView: View {
    @EnvironmentObject var dataModel : DataViewModel
    @EnvironmentObject var navigationManager : NaviagationStateManager
    @EnvironmentObject var validation : FormValidation
    @Environment(\.horizontalSizeClass) var sizeClass : UserInterfaceSizeClass?
    let occupant : Occupant
    @State var done : Bool = false

    var body: some View {
        AdaptiveView {
            VStack {
                VStack (alignment: .center){
                    NameInitials(name: occupant.name, height: 160, width: 170)
                    formBuilder()
                    
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            dataModel.updateOccupant(from: occupant.id, using: validation.occupant)
                            navigationManager.goToProfile(to: validation.occupant)
                        } label: {
                            Text(Buttons.done)
                        }
                        .disabled(!done)
                    }
                }
                Spacer()
            }
            .background(Color.details_background)
            .onAppear(){
                validation.occupant = occupant
            }
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct EditOccupantView_Previews: PreviewProvider {
    static var previews: some View {
        EditOccupantView(occupant: Occupant(name: "", contactNo: "", plateNo: "", vehicle: ""))
            .environmentObject(DataViewModel())
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
    }
}
