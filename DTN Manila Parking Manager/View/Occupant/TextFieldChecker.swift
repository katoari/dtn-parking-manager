//
//  MyTextField.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/16/23.
//

import SwiftUI

struct TextFieldChecker<TextField: View>: View  {
    @EnvironmentObject var validation : FormValidation
    @Binding var text: String
    let oldValue: String
    @Binding var hasChanges: Bool
    var textField: TextField
    
    public init(text : Binding<String>, oldValue : String, hasChanges : Binding<Bool>, @ViewBuilder textField: () -> TextField) {
        self._text = text
        self.oldValue = oldValue
        self._hasChanges = hasChanges
        self.textField = textField()
    }


    var body: some View {
        textField
            .autocorrectionDisabled(true)
            .onChange(of: text, perform: { _ in
                hasChanges = validation.isEditing(oldValue, onChange: text)
            })
    }
}
