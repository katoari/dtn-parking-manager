//
//  BuiltInExtendingViews.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 12/30/22.
//

import SwiftUI
import Combine

// MARK: - Built in Extending Views
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
    func errorDesign(_ errorType : ValidationType) -> some View {
        
        switch errorType {
        case .add:
            foregroundColor(.red)
        case .edit:
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
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
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
