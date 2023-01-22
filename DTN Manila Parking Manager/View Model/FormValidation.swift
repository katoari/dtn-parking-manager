//
//  FormValidation.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/16/23.
//

import Foundation


enum ValidationErrorType {
    case addError
    case editError
}


class FormValidation : ObservableObject {
    @Published var occupant : Occupant = Occupant(id: "", name: "", phone: "", plateNo: "")
    @Published var occupants : [Occupant] = []
    let vehicles = ["Car", "Scooter", "Motorcycle", "Bicycle"]
    
    func isNotValidName() -> Bool {
        let name = occupant.name.removeSpace
        let result = name.count < 2 ? true : false
        //message = "Invalid Name"
        return result
    }
    func isNotValidContactNo() -> Bool {
        let ContactNumber = occupant.phone.removeSpace
        let result = ContactNumber.count != 11 || ContactNumber.isEmpty ? true : false
        //message = "Invalid Contact Number"
        return result
    }
    func isNotValidPlateNo() -> Bool {
        let PlateNumber = occupant.plateNo.removeSpace
        let result = PlateNumber.isEmpty || isPlateNoExist() ? true : false
        //message = "Plate Number is required"
        return result
    }
    func isNotValidVehicle() -> Bool {
        let vehicle = occupant.vehicle.removeSpace
        let result = vehicle != Conditions.bike ? true : false
        return result
    }
    func validationComplete() -> Bool {
        let result = isNotValidName() || isOccupantExist() ||
        isNotValidContactNo() || isNotValidVehicle() && isNotValidPlateNo()
        ? true : false
        return result
    }
    func isNotDiscard() -> Bool{
        let name = occupant.name.removeSpace
        let phone = occupant.phone.removeSpace
        let vehicle = occupant.vehicle.removeSpace
        let PlateNumber = occupant.plateNo.removeSpace
        let result = !name.isEmpty || !phone.isEmpty || vehicle != Conditions.car && PlateNumber.isEmpty ? true : false
        return result
    }
    func isOccupantExist() -> Bool {
        print(occupant.id)
        let result = occupants.map({$0.name}).contains(occupant.name) ? true : false
        return result
    }
    func isPlateNoExist() -> Bool {
        let plateNo = occupants.map({$0.plateNo})
        if !occupant.plateNo.isEmpty {
            let result = plateNo.contains(occupant.plateNo) ? true : false
            return result
        } else {
            return false
        }
    }
    func showOrHideErrors(by error : Bool, type errorType : String) -> String {
        if error {
            return errorType
        } else {
            return ""
        }
    }
    
    
    var sectionError1 : String {
        if occupant.name.isEmpty {
            return "Name is required"
        }
        else if isOccupantExist(){
            return "Name must be unique"
        }
        else if isNotValidName() {
            return "Invalid Name"
        }
        else if occupant.phone.isEmpty{
            return "Phone Number is required"
        }
        else if isNotValidContactNo() {
            return "Invalid Phone Number"
        } else {
            return ""
        }
    }
    var sectionError2 : String {
        if occupant.plateNo.isEmpty && isNotValidVehicle(){
            return "Plate Number is required"
        } else if isPlateNoExist() && isNotValidVehicle() {
            return "Plate Number must be unique"
        }
        else if isNotValidVehicle() && isNotValidPlateNo() {
            return "Invalid Plate Number"
        } else {
            return ""
        }
    }
}
