//
//  NaviagationStateManager.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/14/23.
//

import Foundation


class NaviagationStateManager: ObservableObject {
    
    @Published var selectionState : NavigationState? = nil
    
    func goToEdit(to occupant : Occupant){
        selectionState = .editOccupant(occupant)
    }
    func goToProfile(to occupant : Occupant){
        selectionState = .profileOccupant(occupant)
    }
    
    
}
