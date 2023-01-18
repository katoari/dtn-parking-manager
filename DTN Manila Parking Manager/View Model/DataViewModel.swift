//
//  DataViewModel.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 12/16/22.
//

import Foundation


class DataViewModel : DataHandler {
    @Published var parkingFloors: [ParkingSpace] = []
    @Published var occupants: [Occupant] = []
    @Published var filteredOccupants: [Occupant] = []
    @Published var searchedOccupant = ""
    
    // Singleton
    let firestore = FireStoreDatabase.shared
    let timeKeeper = TimeKeeper.shared
    
    var searchableOccupants: [Occupant] {
        searchedOccupant.isEmpty ? occupants : occupants.filter({$0.name.lowercased().contains(searchedOccupant.lowercased())})
    }
    
    
    init(){
        loadParkingSpace(true) { _ in}
        loadOccupants { _ in}
        reloadOccupants()
    }
    func reload(){
        loadParkingSpace(true) { _ in}
        loadOccupants { _ in}
        reloadOccupants()
    }
    func isParkingAvailable(_ status : String) -> Bool {
        let result = status != Conditions.available ? false : true
        return result
    }
    func carOrBikeIcon(slotType : String) -> String {
        switch slotType {
        case "Bike/Motorcycle":
            return Links.motor
        default:
            return Links.car
        }
    }
    func validateVehicle(vehicle : String, slotType : String) -> Bool {
        let newVehicle = vehicle != Conditions.car ? "Bike/Motorcycle" : vehicle
        let result = newVehicle == slotType  ? true : false
        return result
        
    }
    
    
}
