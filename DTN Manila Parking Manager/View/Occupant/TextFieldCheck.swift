//
//  TextFieldCheck.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/21/23.
//

import SwiftUI

enum FieldType {
    case name
    case phone
    case plateNo
}


struct TextFieldCheck: View {
    let label: String
    @Binding var text: String
    let limit: Int
    let allowed: FieldType
    
    init(_ label: String, text: Binding<String>, limit: Int = Int.max, allowed: FieldType = .name) {
        self.label = label
        self._text = Binding(projectedValue: text)
        self.limit = limit
        self.allowed = allowed
    }
    
    var body: some View {
        TextField(label, text: $text)
            .autocorrectionDisabled(true)
            .onChange(of: text) { _ in
                text = String(text.prefix(limit))
                
                text = text.fieldChecker(type: allowed, text: text)

            }
    }
}
