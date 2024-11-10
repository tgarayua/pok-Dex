//
//  PokeDexApp.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import SwiftUI

@main
struct PokemonApp: App {
    @State var isActive = false
    
    var body: some Scene {
        WindowGroup {
            if isActive{
                ContentView()
            } else {
                SplashScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}
