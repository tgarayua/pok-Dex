//
//  SplashScreenView.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale = 0.6
    @State private var opacity = 0.3
    
    var body: some View {
        ZStack {
            Color.white // Background color for the splash screen
                .ignoresSafeArea()
            
            VStack {
                Image("images")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.scale = 1.0
                            self.opacity = 1.0
                        }
                    }
                
                Text("Pokédex")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5).delay(0.5)) {
                            self.opacity = 1.0
                        }
                    }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

