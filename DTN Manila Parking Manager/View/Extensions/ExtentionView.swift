//
//  ExtentionView.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 12/30/22.
//

import SwiftUI
import Combine



// MARK: - Views Created
extension CardDetailsView {
    @ViewBuilder func isAvailableButton(status : String) -> some View {
        let occupant = dataModel.getOccupant(selected: slot.occupant)
        if dataModel.isParkingAvailable(status){
            AsyncImage(url: URL(string: dataModel.carOrBikeIcon(slotType: slot.type)), scale: 6)
                .onTapGesture {
                    // Open sheet
                    selectionAppear = true
                }
                .sheet(isPresented: self.$selectionAppear) {
                    SelectionView(selectionListAppear: $selectionAppear, slot: slot)
                }

        }
        else {
            HStack {
                Spacer()
                Button {
                    occupantDetailAppear = true
                } label: {
                    Image(systemName: Icons.more)
                        .foregroundColor(.white)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            .if(dataModel.validateOccupant(occupantName: occupant.name, slotOccupant: slot.occupant)) { content in
                content
                    .sheet(isPresented: self.$occupantDetailAppear) {
                        NavigationView {
                            ProfileView(occupant: occupant, slot: slot)
                                .toolbar {
                                    ToolbarItem (placement: .cancellationAction){
                                        Button(Buttons.cancel) {
                                            occupantDetailAppear = false
                                        }
                                    }
                                    ToolbarItem (placement: .principal){
                                        Text(Labels.moreTitle)
                                            .font(.headline)
                                            .bold()
                                    }
                                }

                        }
                        
                        
                    }
            }
            Button {confirmAppear = true}
            label: {
                Text(Buttons.freeUp)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 2, leading: 15, bottom: 2, trailing: 15))
                
                
            }
            .buttonStyle(.borderless)
            .border(Color.white, width: 2, cornerRadius: 25)
            .controlSize(.mini)
            .confirmationDialog(
                Buttons.dialog,
                isPresented: $confirmAppear,
                titleVisibility: .visible) {
                    Button(Buttons.yes){
                        dataModel.populateOccupants()
                        dataModel.updateSlotOccupant(from: slot, newValue: String())
                    }.keyboardShortcut(.defaultAction)
                    Button(Buttons.no, role: .cancel){}
            }
        }
 
    }
    @ViewBuilder func occupantDetails() -> some View {
        let occupant = dataModel.getOccupant(selected: slot.occupant)
        Text(dataModel.isAvailable(occupant.name))
            .font(.headline)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
        if(dataModel.validateOccupant(occupantName: occupant.id, slotOccupant: slot.occupant)){
            Group{
                Text(occupant.phone)
                Text(occupant.plateNo)
            }
            .foregroundColor(.white)
            .font(.footnote)
        }
    }
    
}
extension ProfileView {
    
    @ViewBuilder func DetailsContainer(label occupantLabel : String, detail occupantDetail : String) -> some View {
        HStack {
            VStack (alignment: .leading){
                Text(occupantLabel)
                    .font(.caption)
                Text(occupantDetail)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .padding(10)
            .padding(.horizontal, 10)
            Spacer()
        }
        .background(Color.widget_color)
        .cornerRadius(5)
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
        
    }
    @ViewBuilder func appearDate() -> some View {
        if let mySlot = slot {
            DetailsContainer(label: Labels.date.lowercased(), detail: mySlot.date)
            DetailsContainer(label: Labels.time.lowercased(), detail: mySlot.time)
        } else{
            Text("")
                .toolbar {
                    ToolbarItem {
                        Button {
                            let slot = dataModel.getSlot(by: occupant)
                            if slot != nil {
                                showAlert = true
                            } else {
                                navigationManager.goToEdit(to: occupant)
                            }
                        } label: {
                            Text(Buttons.edit)
                        }
                    }
                }
        }
    }
}

extension AddOccupantView {
    @ViewBuilder func formBuilder() -> some View {
        Form {
            Section {
                    
                TextFieldCheck(Labels.name, text: $validation.occupant.name, limit: 30,
                               allowed: .name)
                    .focused($keyboardFocused)
                    .onChange(of: validation.occupant.name) { name in
                        validation.occupant.id = name
                    }
                TextFieldCheck(Labels.phone, text: $validation.occupant.phone, limit: 11, allowed: .phone)
                    .keyboardType(.phonePad)
            } header: {
                Text(Labels.sectionTitle)
            } footer: {
                Text(validation.showOrHideErrors(by: showErrors, type: validation.sectionError1))
                    .errorDesign(.addError)
            }

            
            Section {
                Picker(selection: $validation.occupant.vehicle, label: Text(Labels.vehicle).font(.title)) {
                    ForEach(validation.vehicles, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                if validation.isNotValidVehicle(){
                    TextFieldCheck(Labels.plateNo, text: $validation.occupant.plateNo, limit: 7, allowed: .plateNo)
                }
            } header: {
                Text(Labels.sectionTitle1)
            } footer: {
                Text(validation.showOrHideErrors(by: showErrors, type: validation.sectionError2))
                    .errorDesign(.addError)
            }
        }
        
    
    }
    
    
}

extension EditOccupantView {
    @ViewBuilder func formBuilder() -> some View {
        Form {
            Section {
                VStack {
                    TextFieldCheck(Labels.name, text: $validation.occupant.name, limit: 30, allowed: .name)
                    .padding(.horizontal, 14).padding(.vertical, 10)
                    Divider()
                        .padding(.leading, 12)
                    TextFieldCheck(Labels.phone, text: $validation.occupant.phone, limit: 11, allowed: .phone)
                        .keyboardType(.phonePad)
                        .padding(.horizontal, 14).padding(.vertical, 10)
                }
                .background(Color.widget_color)
            } footer: {
                Text(validation.showOrHideErrors(by: showErrors, type: validation.sectionError1))
                    .errorDesign(.editError)
            }
            
            Section {
                VStack {
                    Picker(selection: $validation.occupant.vehicle, label: Text(Labels.vehicle)) {
                        ForEach(validation.vehicles, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 14).padding(.vertical, 10)
                Divider()
                    .padding(.leading, 12)
                    if validation.isNotValidVehicle(){
                        TextFieldCheck(Labels.plateNo, text: $validation.occupant.plateNo, limit: 7, allowed: .plateNo)
                            .padding(.horizontal, 14).padding(.vertical, 10)
                    }
                }
                .background(Color.widget_color)
            } footer: {
                Text(validation.showOrHideErrors(by: showErrors, type: validation.sectionError2))
                    .errorDesign(.editError)


            }

        }
        .formStyle(.columns)
    }
    
    
}


// MARK: - Built in Views
extension Color {
    static var details_background: Color {
            Color("default_background")
    }
    static var widget_color: Color {
            Color("widget_color")
    }
    static var section_color: Color {
            Color("section_color")
    }
    static var theme_color: Color {
            Color("theme_color")
    }
    static var available_color: Color {
            Color("available_color")
    }
    static var empty_color: Color {
            Color("occupy_color")
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
    func border(_ color: Color, width: CGFloat, alignment: Alignment) -> some View {
        overlay(Rectangle().frame(width: width, height: 1, alignment: .top).foregroundColor(color), alignment: alignment)
    }
    @ViewBuilder
    func errorDesign(_ errorType : ValidationErrorType) -> some View {
        
        switch errorType {
        case .addError:
            foregroundColor(.red)
        case .editError:
            padding(.horizontal, 14)
                .foregroundColor(.red)
                .font(.caption)
        }

    }
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
    func sync<T:Equatable>(_ published:Binding<T>, with binding:Binding<T>)-> some View{
        self
            .onChange(of: published.wrappedValue) { published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { binding in
                published.wrappedValue = binding
            }
    }
}

extension String {
    var initials: String {
        return self.components(separatedBy: " ")
            .reduce("") {
                ($0.isEmpty ? "" : "\($0.first?.uppercased() ?? "")") +
                ($1.isEmpty ? "" : "\($1.first?.uppercased() ?? "")")
            }
    }
    var removeSpace : String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    var removeEmoji : String {
        return self.unicodeScalars
            .filter { !$0.properties.isEmojiPresentation }
            .reduce("") { $0 + String($1) }
    }
    var removePunctations : String {
        return self.trimmingCharacters(in: NSCharacterSet.punctuationCharacters)
    }
    var removeSymbols : String {
        return self.trimmingCharacters(in: NSCharacterSet.symbols)
    }
    func fieldChecker(type : FieldType, text : String) -> String{
        let def = text.removePunctations.removeSymbols.removeEmoji
        switch type {
        case .name:
            return def
        case .phone:
            let phoneSet : CharacterSet = .decimalDigits
            return String(text.removeEmoji.unicodeScalars.filter(phoneSet.contains))
        case .plateNo:
            return def.removeSpace
        }
    }
}
