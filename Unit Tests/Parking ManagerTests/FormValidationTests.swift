//
//  FormValidationTest.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/17/23.
//

import XCTest
@testable import Parking_Manager

final class FormValidationTest: XCTestCase {
    private var validation : FormValidation!
    var occupants: [Occupant]?
    var occupant : Occupant?
    
    override func setUpWithError() throws {
        validation = FormValidation()
        occupants = [
            Occupant(id: "Anselmo Oduca", name: "Anselmo Oduca", phone: "09774765581", plateNo: "A0001"),
            Occupant(id: "Seraphim Nombre", name: "Seraphim Nombre", phone: "09888321332", plateNo: "A0002"),
            Occupant(id: "Aimee Anjela Dizon", name: "Aimee Anjela Dizon", phone: "09321321321", plateNo: "A0003"),
            Occupant(id: "Lloyd Miguel", name: "Lloyd Miguel", phone: "09888321332", plateNo: "A0004")
            ]
        occupant = Occupant(id: "Mark Joseph Manongsong", name: "Mark Joseph Manongsong", phone: "09132155734", plateNo: "A00123")
    }

    override func tearDownWithError() throws {
        validation = nil
        occupants = nil
        occupant = nil
    }
    
    // test_UnitOfWork_StateUnderTest_ExpectedBehavior
    func test_validation_isValidName_returnsTrue() {
        // ▪ Given
        let name = "Anselmo Oduca"
        validation.occupant.name = name
        // ▪ When
        let nameValidation = validation.isValidName()
        // ▪ Then
        XCTAssertTrue(nameValidation)
        XCTAssertEqual(!validation.occupant.name.isEmpty, nameValidation)
    }
    // test_UnitOfWork_StateUnderTest_ExpectedBehavior
    func test_validation_isValidName_returnsFalse() {
        // ▪ Given
        let name = "A"
        validation.occupant.name = name
        // ▪ When
        let nameValidation = validation.isValidName()
        // ▪ Then
        XCTAssertFalse(nameValidation)
        XCTAssertEqual(validation.occupant.name.isEmpty, nameValidation)
    }
    // test_UnitOfWork_StateUnderTest_ExpectedBehavior
    func test_validation_isValidPhone_returnsTrue() {
        // ▪ Given
        let phone = "09123222161"
        validation.occupant.phone = phone
        // ▪ When
        let phoneValidation = validation.isValidContactNo()
        // ▪ Then
        XCTAssertTrue(phoneValidation)
        XCTAssertEqual(!validation.occupant.phone.isEmpty, phoneValidation)
    }    // test_UnitOfWork_StateUnderTest_ExpectedBehavior
    func test_validation_isValidPhone_returnsFalse() {
        // ▪ Given
        let phone = "0988321"
        validation.occupant.phone = phone
        // ▪ When
        let phoneValidation = validation.isValidContactNo()
        // ▪ Then
        XCTAssertFalse(phoneValidation)
        XCTAssertEqual(validation.occupant.phone.isEmpty, phoneValidation)
    }
    func test_validation_isValidPlateNo_returnsTrue() {
        // ▪ Given
        let plateNo = "AA0091"
        validation.occupant.plateNo = plateNo
        // ▪ When
        let plateNoValidation = validation.isValidPlateNo()
        // ▪ Then
        XCTAssertTrue(plateNoValidation)
        XCTAssertEqual(!validation.occupant.plateNo.isEmpty, plateNoValidation)
    }
    func test_validation_isValidPlateNo_returnsFalse() {
        // ▪ Given
        let plateNo = ""
        validation.occupant.plateNo = plateNo
        // ▪ When
        let plateNoValidation = validation.isValidPlateNo()
        // ▪ Then
        XCTAssertFalse(plateNoValidation)
        XCTAssertEqual(!validation.occupant.plateNo.isEmpty, plateNoValidation)
    }
    func test_validation_isNotBike_returnsTrue() {
        // ▪ Given
        let vehicle = "Motor"
        validation.occupant.vehicle = vehicle
        // ▪ When
        let vehileValidation = validation.isNotBike()
        // ▪ Then
        XCTAssertTrue(vehileValidation)
        XCTAssertEqual(!validation.occupant.vehicle.isEmpty, vehileValidation)
    }
    func test_validation_isNotBike_returnsFalse() {
        // ▪ Given
        let vehicle = "bicycle"
        validation.occupant.vehicle = vehicle
        // ▪ When
        let vehileValidation = validation.isNotBike()
        // ▪ Then
        XCTAssertFalse(vehileValidation)
        XCTAssertEqual(validation.occupant.vehicle.isEmpty, vehileValidation)
    }
    func test_validation_compelete_returnsTrue() {
        // ▪ Given
        validation.occupants = occupants!
        validation.occupant = occupant!
        // ▪ When
        let completeValidation = validation.complete()
        // ▪ Then
        XCTAssertTrue(completeValidation)
        XCTAssertNotEqual(validation.occupants.count, 0)
        XCTAssertNotNil(validation.occupant)
        XCTAssertNotNil(validation.occupants)
    }
    func test_validation_compelete_returnsFalse() {
        // ▪ Given
        occupant = Occupant(id: "Anselmo Oduca", name: "Anselmo Oduca", phone: "09999921422", plateNo: "")
        validation.occupants = occupants!
        validation.occupant = occupant!
        // ▪ When
        let completeValidation = validation.complete()
        // ▪ Then
        XCTAssertFalse(completeValidation)
    
    }

}
