//
//  OccupantsViewModel.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 12/6/22.
//

import Foundation

// MARK: - Occupant Methods
extension DataViewModel {
    
    func loadOccupants(completion : @escaping ([Occupant]?) -> Void) {
        let occupantRef = firestore.getCollection(from: Occupants.collectionName)
        occupantRef.addSnapshotListener { (querySnapshot, error) in
            guard error == nil else{
                completion(nil)
                print(error!.localizedDescription)
                return
            }
            if let snapshot = querySnapshot {
                self.occupants = snapshot.documents.map({ data in
                    let newOccupant = Occupant(
                        name: data[Occupants.nameField] as? String ??  "",
                        contactNo: data[Occupants.contactNoField] as? String ??  "",
                        plateNo: data[Occupants.plateNoField] as? String ??  "",
                        vehicle: data[Occupants.vehicle] as? String ??  "")
                    
                    return newOccupant
                })
                
                
                completion(self.occupants)
                
            }
        }
    }
    func reloadOccupants(){
        loadOccupants { occupants in
            guard let occupants = occupants else {
                return
            }
            self.filteredOccupants = occupants
            for occupant in occupants {
                self.loadParkingSpace (false) { slots in
                    guard let slots = slots else {
                        return
                    }
                    for slot in slots {

                        if occupant.name == slot.occupant {
                            if let index = self.filteredOccupants.firstIndex(where: {$0.id == slot.occupant}){
                                self.filteredOccupants.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }
    func addOccupant(occupant : Occupant){
        let occupantRef = firestore.getCollection(from: Occupants.collectionName)
        occupantRef.document(occupant.name).setData([
            Occupants.nameField: occupant.name,
            Occupants.contactNoField: occupant.contactNo,
            Occupants.vehicle: occupant.vehicle,
            Occupants.plateNoField: occupant.plateNo
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Added \(occupant.name) sucessfully")
            }
        }
        
    }
    func deleteOccupant(occupant : Occupant){
        let occupantRef = firestore.getCollection(from: Occupants.collectionName)
        occupantRef.document(occupant.id).delete() { err in
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
    func updateOccupant(from id : String, using occupant : Occupant){
        let occupantRef = firestore.getCollection(from: Occupants.collectionName).document(id)
        occupantRef.updateData([
            Occupants.nameField : occupant.name,
            Occupants.contactNoField : occupant.contactNo,
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

    func filterOccupants(by slot : Slot) -> [Occupant] {
        let holder = searchedOccupant.isEmpty ? filteredOccupants : filteredOccupants.filter({$0.name.lowercased().contains(searchedOccupant.lowercased())})

        if slot.type == Conditions.car{
            return holder.filter({$0.vehicle == Conditions.car})
        } else{
            return holder.filter({$0.vehicle != Conditions.car})
        }
        
    }
    func getOccupant(selected : String) -> Occupant {
        return occupants.first(where: {$0.name == selected}) ??
        Occupant(name: "", contactNo: "", plateNo: "", vehicle: "")
    }
    func validateOccupant(occupantName : String, slotOccupant : String) -> Bool{
        let result = occupantName == slotOccupant ? true : false
        return result
    }
    func convertOccupant(occupantName : String) -> String {
        let result = occupantName == Conditions.available ? String() : occupantName
        return result
    }

}
