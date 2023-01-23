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
    @State var showErrors : Bool = false
    @State var done : Bool = false

    var body: some View {
        AdaptiveView {
            VStack {
                VStack (alignment: .center){
                    NameInitials(name: validation.occupant.name, height: 160, width: 170)
                    formBuilder()
                    
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            validation.occupants = dataModel.occupants
                            if validation.complete() {
                                dataModel.updateOccupant(validation.occupant)
                                navigationManager.goToProfile(to: validation.occupant)
                            } else {
                                showErrors = true
                            }
                        } label: {
                            Text(Buttons.done)
                        }
                    }
                }
                Spacer()
            }
            .background(Color.details_background)

    
        }
    }
}

struct EditOccupantView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        EditOccupantView()
            .environmentObject(DataViewModel(dataService: dataService))
            .environmentObject(NaviagationStateManager())
            .environmentObject(FormValidation())
    }
}
