//
//  NameInitials.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/16/23.
//

import SwiftUI

struct NameInitials: View {
    let name : String
    
    var height : CGFloat = 150
    var width : CGFloat = 150
    var imageSize : CGFloat = 90
    var fontSize : Font = .largeTitle
    
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray.opacity(8))
                .frame(width: width, height: height)
                .bold()
            if name.isEmpty {
                withAnimation {
                    Image(systemName: Icons.person)
                        .foregroundColor(.white)
                        .font(.system(size: imageSize))
                }
            } else {
                withAnimation {
                    Text(name.initials)
                        .font(fontSize)
                        .scaleEffect(1.18)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .padding(.bottom)
    }
}

struct NameInitials_Previews: PreviewProvider {
    static var previews: some View {
        NameInitials(name: "")
    }
}
