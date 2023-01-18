//
//  DTN_Manila_Parking_ManagerApp.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 11/16/22.
//

import SwiftUI
import FirebaseCore

@main
struct DTN_Manila_Parking_ManagerApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
      
    var body: some Scene {
      WindowGroup {
        ContentView()
      }
    }}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
