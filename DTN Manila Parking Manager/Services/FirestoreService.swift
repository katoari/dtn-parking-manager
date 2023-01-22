//
//  FirestoreService.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/19/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirestoreService : DataSubscription {
    private let db = Firestore.firestore()
    private let timeKeeper = TimeKeeper.shared

    
    private var parkingRef : CollectionReference {
        db.collection(ParkingSpaces.collectionName)
    }
    private var occupantRef : CollectionReference {
        db.collection(Occupants.collectionName)
    }
    
    
    
    
    func fetchOccupants(completion : @escaping ([Occupant]?) -> Void){
        var occupants : [Occupant] = []
        _ = occupantRef.addSnapshotListener { query, error in
            guard error == nil else{
                completion(nil)
                return
            }
            
            if let snapshot = query {
                occupants = snapshot.documents.map { document in

                    let occupant = Occupant(
                        id: document.documentID,
                        name: document[Occupants.nameField] as? String ?? "",
                        phone: document[Occupants.contactNoField] as? String ?? "",
                        plateNo: document[Occupants.plateNoField] as? String ?? "",
                        vehicle: document[Occupants.vehicle] as? String ?? "")
                    return occupant
                }
                
                completion(occupants)
            }
        }
    }
    func fetchFloors(completion : @escaping ([String]?) -> Void){
        var floors : [String] = []
        _ = parkingRef.addSnapshotListener { query, error in
            guard error == nil else{
                completion(nil)
                return
            }
            
            if let snapshot = query {
                floors = snapshot.documents.map({$0.documentID})
                completion(floors)
            }
        }
    }
    func fetchParkingSpace(completion : @escaping ([ParkingSpace]?) -> Void){
        var slots : [Slot] = []
        var parkingSpace : [ParkingSpace] = []
        fetchFloors { floors in
            guard let floors = floors else {
                return
            }
            
            for floor in floors {
                let slotRef = self.parkingRef.document(floor).collection(Slots.collectionName).order(by: "Floor")
                
                slotRef.addSnapshotListener { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    if let snapshot = snapshot {
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

                    if let index = parkingSpace.firstIndex(where: {$0.title == floor}){
                        parkingSpace[index].slots = slots
                    } else{
                        parkingSpace.append(parkingFloor)
                    }
                    
                    
                    completion(parkingSpace)
                }

            }
        }
        
    }
    func addOccupant(_ newOccupant : Occupant){
        occupantRef.document(newOccupant.id).setData([
            Occupants.nameField: newOccupant.name,
            Occupants.contactNoField: newOccupant.phone,
            Occupants.vehicle: newOccupant.vehicle,
            Occupants.plateNoField: newOccupant.plateNo
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Added \(newOccupant.name) sucessfully")
            }
        }
    }
    func updateOccupant(_ occupant : Occupant){
        occupantRef.document(occupant.id).updateData([
            Occupants.nameField : occupant.name,
            Occupants.contactNoField : occupant.phone,
            Occupants.plateNoField : occupant.plateNo,
            Occupants.vehicle : occupant.vehicle
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    func deleteOccupant(_ occupant : Occupant){
        occupantRef.document(occupant.id).delete() { err in
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
    func updateSlotOccupant(from slot : Slot, newValue : String){
        let slotRef = self.parkingRef.document(slot.parkingSpaceID).collection(Slots.collectionName).document(slot.id)
        let new = newValue == Conditions.available ? String() : newValue
        slotRef.updateData([
            Slots.occupantField : new
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    func updateSlotDate(from slot : Slot, newValue : String){
        let slotRef = self.parkingRef.document(slot.parkingSpaceID).collection(Slots.collectionName).document(slot.id)
        let convertedDateTime = timeKeeper.stringToDate(dateTime: newValue)
    
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
