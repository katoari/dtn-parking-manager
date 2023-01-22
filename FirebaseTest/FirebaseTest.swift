//
//  FirebaseTest.swift
//  FirebaseTest
//
//  Created by Anselmo Oduca on 1/21/23.
//

import XCTest
import Firebase


final class FirebaseTest: XCTestCase {
    private var firebaseService : FirestoreService!
    private var vm : DataViewModel!
    
    
    override func setUpWithError() throws {
        FirebaseApp.configure()
        firebaseService = FirestoreService()
        vm = DataViewModel()
    }
    override func tearDown() {
        firebaseService = nil
        vm = nil
    }
    
    // Loading Floors returns all default floors
    func test_loadFloors_returnsFloors () {
        firebaseService.fetchFloors { actual in
            guard let actual = actual else {
                return
            }

            let expected = ["6th Floor", "7th Floor", "Basement 5"]
            XCTAssertEqual(actual, expected)
        }
    }
    
    func test_isEqualBike_returnBikeLink(){
        let actual = vm.carOrBikeIcon(slotType: "bike/motorcycle")
        let expected = "https://cdn-icons-png.flaticon.com/512/1048/1048323.png"
        
        XCTAssertEqual(actual, expected)
    }
    func test_isEqualCar_returnCarLink(){
        let actual = vm.carOrBikeIcon(slotType: "car")
        let expected = "https://cdn-icons-png.flaticon.com/512/1048/1048313.png"
        
        XCTAssertEqual(actual, expected)
    }
    
}
