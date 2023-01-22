//
//  ParkingSpace.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/5/22.
//

import Foundation


struct ParkingSpace : Identifiable, Equatable, Hashable, Codable {
    var id : String {title}
    var title : String
    var slots : [Slot]
    
    static func == (lhs: ParkingSpace, rhs: ParkingSpace) -> Bool {
        return(
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.slots == rhs.slots)
    }
    
}
