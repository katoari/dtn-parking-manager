//
//  OccupantsService.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/14/22.
//

import Foundation
import SwiftUI


class OccupantsService : ObservableObject {
    
    

    func isItRedOrGreen(_ status : String) -> Color{
        //print(status)
        
        
        let result = status != Constants.available ?
        Color(red: 1, green: 0, blue: 0) : Color(red: 0.573, green: 0.816, blue: 0.318)
        //  #Red : #Green
        return result
    }
}
