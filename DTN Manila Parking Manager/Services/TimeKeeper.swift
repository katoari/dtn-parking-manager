//
//  DateAndTimeHandler.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/7/23.
//

import Foundation
import FirebaseFirestore



class TimeKeeper: ObservableObject {
    private var currentTime = Date()
    private let timeFormat = DateFormatter()
    
    static var shared: TimeKeeper = {
        let instance = TimeKeeper()
        return instance
    }()
    private init() {
    }
    
    func createCurrentDateTime() -> String {
        currentTime = Date()
        timeFormat.dateFormat = "dd.MM.yyyy h:mm a"
        timeFormat.timeZone = TimeZone(abbreviation: "GMT")
        
        return timeFormat.string(from: currentTime)
        
    }
    func dateToString(timeResult : Timestamp) -> String {
        currentTime = Date(timeIntervalSince1970: TimeInterval(timeResult.seconds))
        let timezone = TimeZone.current.abbreviation() ?? "GMT"
        timeFormat.timeZone = TimeZone(abbreviation: timezone)
        timeFormat.locale = NSLocale.current
        timeFormat.dateFormat = "dd/MM/yyyy"
        let strDate = timeFormat.string(from: currentTime)
        
        return strDate
    }
    func clockToString(timeResult : Timestamp) -> String {
        currentTime = Date(timeIntervalSince1970: TimeInterval(timeResult.seconds))
        let timezone = TimeZone.current.abbreviation() ?? "GMT"
        timeFormat.timeZone = TimeZone(abbreviation: timezone)
        timeFormat.locale = NSLocale.current
        timeFormat.dateFormat = "h:mm a"
        let strDate = timeFormat.string(from: currentTime)
        
        return strDate
    }
    
    
    func stringToDate(dateTime : String) -> Date {
        timeFormat.dateFormat = "dd.MM.yyyy h:mm a"
        timeFormat.timeZone = TimeZone(abbreviation: "GMT")
        let dateGMT = timeFormat.date(from: dateTime)
        return dateGMT!
        
    }
    
    

    

    
}
