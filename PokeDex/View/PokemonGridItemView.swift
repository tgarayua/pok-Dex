//
//  PokemonGridItemView.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import SwiftUI

struct PokemonGridItemView: View {
    let pokemon: PokemonListItem
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            // Image placeholder with animation
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(extractPokemonID(from: pokemon.url)).png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .scaleEffect(1.5)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isAnimating)
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(pokemon.name.capitalized)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 5)
                .scaleEffect(isAnimating ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isAnimating)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
        )
        .onAppear {
            isAnimating = true
        }
    }

    // Helper function to extract the Pokémon ID from its URL
    private func extractPokemonID(from url: String) -> String {
        let parts = url.split(separator: "/")
        return parts.last.map(String.init) ?? "1" // default to "1" if there's an issue
    }
}

