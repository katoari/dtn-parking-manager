//
//  Occupant.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/6/22.
//

import Foundation


struct Occupant: Identifiable, Equatable,  Hashable, Codable{
    var id : String {name}
    var name: String
    var contactNo : String
    var plateNo : String
    var vehicle : String = "Car"
    
    static func == (lhs: Occupant, rhs: Occupant) -> Bool {
        return(
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.contactNo == rhs.contactNo &&
        lhs.plateNo == lhs.plateNo &&
        lhs.vehicle == lhs.vehicle)
    }
    

}
