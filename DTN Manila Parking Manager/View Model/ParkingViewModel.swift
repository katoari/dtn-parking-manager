//
//  ParkingSpacesViewModel.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 12/6/22.
//

import Foundation
import FirebaseFirestore

// MARK: - Parking Space Methods
extension DataViewModel {
    
    func loadFloors(completion : @escaping ([String]?) -> Void){
        let parkingRef = firestore.getCollection(from: ParkingSpaces.collectionName)
        parkingRef.addSnapshotListener { snapshot, error in
            //self.parkingFloors = []
            guard error == nil else {
                completion(nil)
                return
            }
            if let parkingSnapshot = snapshot {
                let floors = parkingSnapshot.documents.map({$0.documentID})
                completion(floors)
            }
        }
    }
    func loadParkingSpace(_ refresh : Bool, completion : @escaping ([Slot]?) -> Void) {
        
        var slots : [Slot]?
        let parkingRef = firestore.getCollection(from: ParkingSpaces.collectionName)
        loadFloors { floors in
            guard let floors = floors else {
                return
            }
            
            for floor in floors {
                if refresh {
                    self.parkingFloors = []
                }
                
                let slotRef = self.firestore
                    .getSubCollection(from: parkingRef, to: floor, andFrom: Slots.collectionName)
                
                slotRef.addSnapshotListener { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    if let snapshot = snapshot {
                        //print(floor)
                        slots = snapshot.documents.map({ data in
                            let slotOccupant = data[Slots.occupantField] as? String ?? ""
                            let timeResult = data[Slots.dateTimeField] as? Timestamp ?? Timestamp(seconds: 0, nanoseconds: 0)
                            
                            
                            let strDate = self.timeKeeper.dateToString(timeResult: timeResult)
                            let clock = self.timeKeeper.clockToString(timeResult: timeResult)
                            return Slot(id: data.documentID,
                                        occupant: slotOccupant.isEmpty ? Conditions.available : slotOccupant,
                                        date: strDate,
                                        time: clock,
                                        type: data[Slots.allowedVehicle] as? String ?? "",
                                        parkingSpaceID: floor)
                        })
                        
                    }
                    let parkingFloor = ParkingSpace(title: floor, slots: slots)
                    
                    if let index = self.parkingFloors.firstIndex(where: {$0.title == floor}){
                        self.parkingFloors[index].slots = slots
                    } else{
                        self.parkingFloors.append(parkingFloor)
                    }
                    
                    completion(slots)
                }

            }
        }
        
        
    }
    func updateSlotOccupant(floor : String, slotNumber : String, newValue : String){
        let parkingRef = firestore.getCollection(from: ParkingSpaces.collectionName)
        let slotRef = firestore.getSubCollection(from: parkingRef, to: floor, andFrom: Slots.collectionName).document(slotNumber)
        let convert = self.convertOccupant(occupantName: newValue)
        
        
        slotRef.updateData([
            Slots.occupantField : convert
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func updateSlotDate(floor : String, slotNumber : String, newValue : String){
        let parkingRef = firestore.getCollection(from: ParkingSpaces.collectionName)
        let slotRef = firestore.getSubCollection(from: parkingRef, to: floor, andFrom: Slots.collectionName).document(slotNumber)
        let convertedDateTime = self.timeKeeper.stringToDate(dateTime: newValue)
        
        
        slotRef.updateData([
            Slots.dateTimeField : convertedDateTime
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
}
