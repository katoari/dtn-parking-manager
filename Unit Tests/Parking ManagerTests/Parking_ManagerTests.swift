//
//  Parking_ManagerTests.swift
//  Parking ManagerTests
//
//  Created by Anselmo Oduca on 1/15/23.
//

import XCTest
@testable import Parking_Manager

final class Parking_ManagerTests: XCTestCase {
    private var vm : DataViewModel!

    override func setUpWithError() throws {
        vm = DataViewModel(dataService: FirestoreService())
    }

    override func tearDownWithError() throws {
        vm = nil
    }


    func test_validation_parkingSpaceID_returnsTrue() {
        // ▪ Given
        vm.populateOccupants()
        // ▪ When
        // ▪ Then
    }

}
