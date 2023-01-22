//
//  SectionView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 11/21/22.
//

import SwiftUI

struct SectionView: View {
    @EnvironmentObject var dataModel : DataViewModel
    
    var body: some View {
        List {
            ForEach(dataModel.parkingFloors) { parkingSpace in
                Section {
                    CardView(slots: parkingSpace.slots)
                } header: {
                    HStack {
                        Text(parkingSpace.title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }
                    .background(Color.section_color)
                    .listRowInsets(EdgeInsets())
                }
            }
            
        }
        .listRowBackground(Color.clear)
        .listStyle(GroupedListStyle())


    }
}

struct HeaderView_Previews: PreviewProvider {
    static let dataService = FirestoreService()
    static var previews: some View {
        Group {
            SectionView()
                .environmentObject(DataViewModel(dataService: dataService))
                .previewLayout(.sizeThatFits)
        }
    }
}
