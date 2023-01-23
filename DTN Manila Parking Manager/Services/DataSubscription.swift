//
//  DataHandler.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/23/22.
//

import Foundation

protocol DataSubscription {
    var parkingSpace : [ParkingSpace] {get set}
    var occupants : [Occupant] {get set}
    

    func fetchOccupants(completion : @escaping ([Occupant]?) -> Void)
    func fetchParkingSpace(completion : @escaping ([ParkingSpace]?) -> Void)
    func addOccupant(_ newOccupant : Occupant)
    func updateOccupant(_ occupant : Occupant)
    func deleteOccupant(_ occupant : Occupant)
    func freeUpOrOccupy(from slot : Slot, newValue : String)
    func updateSlotDate(from slot : Slot, newValue : String)
}
