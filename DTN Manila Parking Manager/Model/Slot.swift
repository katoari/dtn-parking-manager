//
//  Slot.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/6/22.
//

import Foundation



struct Slot : Identifiable, Equatable,Codable, Hashable {
    
    let id: String
    let occupant: String
    let date: String
    let time: String
    let type: String
    let parkingSpaceID : String
    
    
    static func == (lhs: Slot, rhs: Slot) -> Bool {
        return(
        lhs.id == rhs.id &&
        lhs.occupant == rhs.occupant &&
        lhs.date == rhs.date &&
        lhs.time == rhs.time &&
        lhs.type == rhs.type &&
        lhs.parkingSpaceID == rhs.parkingSpaceID)
    }
    
    static var defaultSlot = Slot(id: "", occupant: "", date: "", time: "", type: "", parkingSpaceID: "")
}
