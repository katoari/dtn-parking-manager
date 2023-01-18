//
//  ParkingSlotView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/21/22.
//

import SwiftUI

struct ParkingSlotView: View {
    @EnvironmentObject var dataModel : DataViewModel
    var body: some View {
        SectionView()
            .refreshable (action: {dataModel.reload()})
        
    }
}





struct ParkingSlotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParkingSlotView()
                .environmentObject(DataViewModel())
                .previewLayout(.sizeThatFits)
        }
    }
}
