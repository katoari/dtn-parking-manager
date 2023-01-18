//
//  FormValidation.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/16/23.
//

import Foundation



class FormValidation : ObservableObject {
    
    
    @Published var occupant : Occupant = Occupant(name: "", contactNo: "", plateNo: "")
    @Published var message = ""
    
    let vehicles = ["Car", "Scooter", "Motorcycle", "Bicycle"]

    
    func isNotValidName() -> Bool {
        let name = occupant.name.removeSpace
        let result = name.count < 2 || name.isEmpty ? true : false
        return result
    }
    func isNotValidContactNo() -> Bool {
        let contactNo = occupant.contactNo.removeSpace
        let result = contactNo.count != 11 || contactNo.isEmpty ? true : false
        return result
    }
    func isNotValidPlateNo() -> Bool {
        let plateNo = occupant.plateNo.removeSpace
        let result = plateNo.count < 6 || plateNo.isEmpty ? true : false
        return result
    }
    func isNotValidVehicle() -> Bool {
        let vehicle = occupant.vehicle.removeSpace
        let result = vehicle != Conditions.bike ? true : false
        return result
    }
    func limitContactNo(_ limit : Int) {
        if occupant.contactNo.count > limit {
            occupant.contactNo = String(occupant.contactNo.prefix(limit))
        }
    }
    func isAddOccupantComplete() -> Bool {
        let result = isNotValidName() || isNotValidContactNo() || isNotValidVehicle() && isNotValidPlateNo()
        ? true : false
        return result
    }
    func isEditing( _ oldValue : String, onChange : String) -> Bool {
        
        let result =  !onChange.isEmpty && onChange != oldValue ? true : false
        return result
    }
    func isNotEmpty() -> Bool{
        let name = occupant.name
        let phone = occupant.contactNo
        let vehicle = occupant.vehicle
        let plateNo = occupant.plateNo
        
        let result = !name.isEmpty || !phone.isEmpty || vehicle == Conditions.bike && plateNo.isEmpty ? true : false
        
        return result
    }
    
}
