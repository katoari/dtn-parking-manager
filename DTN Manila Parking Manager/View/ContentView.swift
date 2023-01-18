//
//  ContentView.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 11/16/22.
//

import SwiftUI

struct ContentView: View {

    init(){
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View{
        SplashScreen (load: State(wrappedValue: true)){
            HomeView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
