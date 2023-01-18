//
//  DataHandler.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/23/22.
//

import Foundation

protocol DataHandler : ObservableObject {
    func loadParkingSpace(_ refresh : Bool, completion : @escaping ([Slot]?) -> Void)
    func loadOccupants(completion : @escaping ([Occupant]?) -> Void)
}
