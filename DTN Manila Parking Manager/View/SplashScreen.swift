//
//  SplashScreen.swift
//  DTN Manila Parking Manager
//
//  Created by Anselmo Oduca on 1/16/23.
//

import SwiftUI

struct SplashScreen<Content: View>: View {
    var content: Content
    @State var load = true
    @State var size = 0.8
    @State var opacity = 0.5
    
    
    public init(load : State<Bool>, @ViewBuilder content: () -> Content) {
        self._load = load
        self.content = content()
    }
    
    var body: some View {
        if !load {
            content
        }
        else {
            ZStack (alignment: .center){
                Color.white
                    .ignoresSafeArea()
               
                VStack {
                    Spacer()
                    VStack {
                        Image.splash_logo
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear(){
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 1.2
                            self.opacity = 1.0
                            
                        }
                    }
                    Spacer()
                    Image.dtn_logo
                        .resizable()
                        .frame(width: 175, height: 40)
                        .padding(.bottom)

                }
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.load = false
                    }
                }
                

            }
        }
    }
}
