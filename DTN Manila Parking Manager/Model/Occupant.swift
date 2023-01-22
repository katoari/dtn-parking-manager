//
//  Occupant.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/6/22.
//

import Foundation


struct Occupant: Identifiable, Equatable,  Hashable, Codable{
    var id : String
    var name: String
    var phone : String
    var plateNo : String
    var vehicle : String = "Car"
    
    static func == (lhs: Occupant, rhs: Occupant) -> Bool {
        return(
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.phone == rhs.phone &&
        lhs.plateNo == rhs.phone &&
        lhs.vehicle == rhs.vehicle)
    }
    
    
    static var defaultOccupant = Occupant(id: "", name: "", phone: "", plateNo: "")
    

}
