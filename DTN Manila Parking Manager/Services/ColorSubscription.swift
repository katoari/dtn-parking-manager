//
//  ColorHandler.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/22/23.
//

import Foundation
import SwiftUI


protocol DefaultColorTheme {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}
protocol AppTheme {
    var section: Color { get }
    var available: Color { get }
    var occupy: Color { get }
}


struct ParkingManagerTheme : DefaultColorTheme, AppTheme {
    let primary: Color = Color("theme_color")
    let secondary: Color = Color("default_background")
    let tertiary: Color = Color("widget_color")
    let section: Color = Color("section_color")
    let available: Color = Color("available_color")
    let occupy: Color = Color("occupy_color")
}
