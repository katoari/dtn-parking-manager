//
//  MockDataService.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/17/23.
//

import Foundation


class MockDataService : DataSubscription {
    
    
    let testParkingSpaces: [ParkingSpace] = [
        ParkingSpace(title: "6th Floor", slots: [
            Slot(id: "601", occupant: "Available", date: "01/17/23", time: "4:21 AM", type: "Car", parkingSpaceID: "6th Floor"),
            Slot(id: "602", occupant: "Anselmo Oduca", date: "01/19/23", time: "6:24 AM", type: "Car", parkingSpaceID: "6th Floor"),
            Slot(id: "603", occupant: "Seraphim Nombre", date: "01/18/23", time: "2:21 AM", type: "Car", parkingSpaceID: "6th Floor"),
            Slot(id: "604", occupant: "Aimee Anjela Dizon", date: "01/12/23", time: "2:21 AM", type: "Car", parkingSpaceID: "6th Floor")
            ]
        ),
        ParkingSpace(title: "7th Floor", slots: [
            Slot(id: "701", occupant: "Available", date: "01/17/23", time: "4:21 AM", type: "bike", parkingSpaceID: "7th Floor"),
            Slot(id: "702", occupant: "Available", date: "01/17/23", time: "4:21 AM", type: "bike/motOrcycle", parkingSpaceID: "7th Floor")
            ]
        ),
        ParkingSpace(title: "Basement 5", slots: [
            Slot(id: "1", occupant: "Available", date: "01/17/23", time: "4:21 AM", type: "Car", parkingSpaceID: "Basement 5"),
            Slot(id: "2", occupant: "Available", date: "01/17/23", time: "4:21 AM", type: "bIKe/motoRcycle", parkingSpaceID: "Basement 5"),
            ]
        ),
    ]
    let testOccupants: [Occupant] = [
        Occupant(id: "Anselmo Oduca", name: "Anselmo Oduca", phone: "09774765581", plateNo: "A0001"),
        Occupant(id: "Seraphim Nombre", name: "Seraphim Nombre", phone: "09888321332", plateNo: "A0002"),
        Occupant(id: "Aimee Anjela Dizon", name: "Aimee Anjela Dizon", phone: "09321321321", plateNo: "A0003"),
        Occupant(id: "Lloyd Miguel", name: "Lloyd Miguel", phone: "09888321332", plateNo: "A0002")
    ]
    
    
    func fetchOccupants(completion: @escaping ([Occupant]?) -> Void) {
        completion(testOccupants)
    }
    
    func fetchParkingSpace(completion: @escaping ([ParkingSpace]?) -> Void) {
        completion(testParkingSpaces)
    }
    
    func addOccupant(_ newOccupant: Occupant) {
        
    }

    func updateOccupant(_ occupant: Occupant) {
        
    }

    func deleteOccupant(_ occupant: Occupant) {
    }

    func updateSlotOccupant(from slot: Slot, newValue: String) {
        
    }

    func updateSlotDate(from slot: Slot, newValue: String) {
        
    }
    
    
    
    
}
