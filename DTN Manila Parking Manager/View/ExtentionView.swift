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
                        dataModel.reloadOccupants()
                        dataModel.updateSlotOccupant(floor: slot.parkingSpaceID, slotNumber: slot.id, newValue: String())
                    }.keyboardShortcut(.defaultAction)
                    Button(Buttons.no, role: .cancel){}
            }
        }
 
    }
    @ViewBuilder func occupantDetails() -> some View {
        let occupant = dataModel.getOccupant(selected: slot.occupant)
        if(dataModel.validateOccupant(occupantName: occupant.name, slotOccupant: slot.occupant)){
            Group{
                Text(occupant.contactNo)
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
                            navigationManager.goToEdit(to: occupant)
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
            Section (Labels.sectionTitle){
                TextField(Labels.name, text: $validation.occupant.name)
                    .focused($keyboardFocused)
                    .autocorrectionDisabled(true)
                TextField("Contact Number", text: $validation.occupant.contactNo)
                    .keyboardType(.phonePad)
                    .onReceive(Just(validation.occupant.contactNo), perform: { _ in
                        validation.limitContactNo(11)
                    })
                    .autocorrectionDisabled(true)

            }

            Section (Labels.sectionTitle1){
                Picker(selection: $validation.occupant.vehicle, label: Text(Labels.vehicle).font(.title)) {
                    ForEach(validation.vehicles, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                if validation.occupant.vehicle != Conditions.bike{
                    TextField(Labels.plateNo, text: $validation.occupant.plateNo)
                        .autocorrectionDisabled(true)
                }
            }
        }
        .scrollContentBackground(.hidden)
    
    }
    
    
}

extension EditOccupantView {
    @ViewBuilder func formBuilder() -> some View {

        ScrollView {
            VStack {
                VStack {
                    TextFieldChecker(text: $validation.occupant.name, oldValue: occupant.name, hasChanges: $done, textField: {
                        TextField(Labels.name, text: $validation.occupant.name)
                    })
                        .padding(.horizontal, 14).padding(.vertical, 10)
                    Divider()
                        .padding(.leading, 12)
                    TextFieldChecker(text: $validation.occupant.contactNo, oldValue: occupant.contactNo, hasChanges: $done, textField: {
                        TextField(Labels.phone, text: $validation.occupant.contactNo)
                            .onReceive(Just(validation.occupant.contactNo), perform: { _ in
                                validation.limitContactNo(11)
                            })
                            .autocorrectionDisabled(true)
                            .keyboardType(.phonePad)
                            .padding(.horizontal, 14).padding(.vertical, 10)
                    })
                }
                .background(Color.widget_color)
                .padding(.bottom)
                VStack {
                    TextFieldChecker(text: $validation.occupant.vehicle, oldValue: occupant.vehicle, hasChanges: $done) {
                        Picker(selection: $validation.occupant.vehicle, label: Text(Labels.vehicle)) {
                            ForEach(validation.vehicles, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 14).padding(.vertical, 10)
                    }
                Divider()
                    .padding(.leading, 12)
                    if validation.occupant.vehicle != Conditions.bike{
                        TextFieldChecker(text: $validation.occupant.plateNo, oldValue: occupant.plateNo, hasChanges: $done, textField: {
                            TextField(Labels.plateNo, text: $validation.occupant.plateNo)
                        })
                            .padding(.horizontal, 14).padding(.vertical, 10)
                    }
                }
                .background(Color.widget_color)
                .padding(.bottom)
            }
            .scrollContentBackground(.hidden)
        .formStyle(.columns)
        }
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
            Color("empty_color")
    }
}

extension Image {
    static var splash_logo: Image{
        Image("splash_logo")
    }
    static var dtn_logo: Image{
        Image("dtn_logo")
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
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
    func getScreenBounds() -> CGRect{
        return UIScreen.main.bounds
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
        return self.trimmingCharacters(in: .whitespaces)
    }
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
