//
//  NavigationState.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/14/23.
//

import Foundation


enum NavigationState: Hashable, Codable {
    case profileOccupant(Occupant)
    case editOccupant(Occupant)
}
