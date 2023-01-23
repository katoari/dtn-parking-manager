//
//  FormValidation.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/16/23.
//

import Foundation



enum ValidationType {
    case add
    case edit
}


class FormValidation : ObservableObject {
    @Published var occupant : Occupant = Occupant(id: "", name: "", phone: "", plateNo: "")
    @Published var occupants : [Occupant] = []
    let vehicles = ["Car", "Scooter", "Motorcycle", "Bicycle"]
    
    func isValidName() -> Bool {
        let name = occupant.name
        let result = name.count > 2 ? true : false
        return result
    }
    func isValidContactNo() -> Bool {
        let phone = occupant.phone
        let result = phone.count == 11 ? true : false
        return result
    }
    func isValidPlateNo() -> Bool {
        let plateNo = occupant.plateNo
        let result = !plateNo.isEmpty ? true : false
        return result
    }
    func isNotBike() -> Bool {
        let vehicle = occupant.vehicle.lowercased()
        let result = vehicle != Conditions.bike.lowercased() ? true : false
        return result
    }
    func complete() -> Bool {
        let bikeCondition = isValidName() && isValidContactNo() && !occupantExist()
        let notBikeCondition = bikeCondition && !plateNoExist() && isValidPlateNo()
        let bikeOrNot = isNotBike() ? notBikeCondition : bikeCondition
        let result = bikeOrNot
        ? true : false
        return result
    }
    func isNotDiscard() -> Bool{
        let result = !occupant.name.isEmpty || isValidContactNo() ||  (!isNotBike() && !isValidPlateNo()) ? true : false
        return result
    }
    func occupantExist() -> Bool {
        let result = occupants.map({$0.name}).contains(occupant.name) ? true : false
        return result
    }
    func plateNoExist() -> Bool {
        let plateNo = occupants.map({$0.plateNo})
        
        let result = plateNo.contains(occupant.plateNo) ? true : false
        return result

    }
    func showOrHideErrors(by error : Bool, type errorType : String) -> String {
        let result = error ? errorType : ""
        return result
    }
    
    
    var sectionError1 : String {
        if occupant.name.isEmpty {
            return "Name is required"
        }
        else if occupantExist(){
            return "Name already taken"
        }
        else if !isValidName() {
            return "Invalid Name"
        }
        else if occupant.phone.isEmpty{
            return "Phone Number is required"
        }
        else if !isValidContactNo() {
            return "Invalid Phone Number"
        } else {
            return String()
        }
    }
    
    var sectionError2 : String {
        if isNotBike() && (!isValidPlateNo()){
            return "Plate Number is required"
        } else if isNotBike() && plateNoExist() {
            return "Plate Number already taken"
        } else {
            return String()
        }
    }
}
