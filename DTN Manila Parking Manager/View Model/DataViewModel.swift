//
//  DataViewModel.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 12/16/22.
//

import Foundation


class DataViewModel : ObservableObject {
    @Published var parkingFloors: [ParkingSpace] = []
    @Published var occupants: [Occupant] = []
    @Published var searchedOccupant = ""
    private let dataService : DataSubscription
    
    init(dataService :  DataSubscription){
        self.dataService = dataService
        populateParkingSpace()
        populateOccupants()
    }
    
    
    
    
    
    func populateParkingSpace(){
        dataService.fetchParkingSpace { parkingSpace in
            guard let parkingSpace = parkingSpace else {
                return
            }
            
            self.parkingFloors = parkingSpace
            self.parkingFloors = self.parkingFloors.sorted(by: { first, last in
                first.title < last.title
            })
        }
    }
    func updateSlotOccupant(from slot : Slot, newValue : String){
        dataService.updateSlotOccupant(from: slot, newValue: newValue)
        
    }
    func updateSlotDate(from slot: Slot, newValue : String){
        dataService.updateSlotDate(from: slot, newValue: newValue)
    }
    func populateOccupants() {
        dataService.fetchOccupants { occupants in
            guard let occupants = occupants else {
                return
            }
            self.occupants = occupants
        }
        
    }
    func addOccupant(occupant : Occupant) {
        dataService.addOccupant(occupant)
    }
    func updateOccupant(_ occupant : Occupant) {
        dataService.updateOccupant(occupant)
    }
    func deleteOccupant(_ occupant : Occupant){
        dataService.deleteOccupant(occupant)
    }
    func filterOccupants(by slot : Slot) -> [Occupant] {
        var holder = occupants
        for occupant in holder {
            for parkingFloor in parkingFloors {
                for slot in parkingFloor.slots{
                    if occupant.id == slot.occupant{
                        if let index = holder.firstIndex(where: {$0.id == slot.occupant}){
                            holder.remove(at: index)
                            
 
                        }
                    }
                    
                }
            }
        }
        holder = searchableOccupants(type: holder)
        if slot.type == Conditions.car{
            return holder.filter({$0.vehicle == Conditions.car})
        } else{
            return holder.filter({$0.vehicle != Conditions.car})
        }
    }
    
    func searchableOccupants(type occupants : [Occupant]) -> [Occupant]{
        let search = searchedOccupant.isEmpty ? occupants : occupants.filter({$0.id.lowercased().contains(searchedOccupant.lowercased())})
        return search
    }
    func reload(){
        populateParkingSpace()
        populateOccupants()
    }
    func isParkingAvailable(_ status : String) -> Bool {
        let result = status != Conditions.available ? false : true
        return result
    }
    func carOrBikeIcon(slotType : String) -> String {
        let type = slotType.lowercased()
        switch type {
        case "bike/motorcycle":
            return Links.motor
        default:
            return Links.car
        }
    }
    func getOccupant(selected : String) -> Occupant {
        return occupants.first(where: {$0.id == selected}) ?? Occupant.defaultOccupant
    }
    func getSlot(by occupant : Occupant) -> Slot? {
        for floor in parkingFloors {
            for slot in floor.slots {
                if slot.occupant == occupant.id {
                    return slot
                }
            }
        }
        return nil
    }
    func validateOccupant(occupantName : String, slotOccupant : String) -> Bool{
        let result = occupantName == slotOccupant ? true : false
        return result
    }
    func isAvailable(_ status : String) -> String {
        let result = status.isEmpty ? Conditions.available : status
        
        return result
    }
    
}
