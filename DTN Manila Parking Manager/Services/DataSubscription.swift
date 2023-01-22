//
//  DataHandler.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/23/22.
//

import Foundation

protocol DataSubscription {
    func fetchOccupants(completion : @escaping ([Occupant]?) -> Void)
    func fetchParkingSpace(completion : @escaping ([ParkingSpace]?) -> Void)
    func addOccupant(_ newOccupant : Occupant)
    func updateOccupant(_ occupant : Occupant)
    func deleteOccupant(_ occupant : Occupant)
    func updateSlotOccupant(from slot : Slot, newValue : String)
    func updateSlotDate(from slot : Slot, newValue : String)
}
