//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let pokemonUrl: String
    
    var body: some View {
        ZStack {
            // Background color that changes based on type
            viewModel.typeColor()
                .ignoresSafeArea()
                .opacity(0.3)
                .animation(.easeInOut, value: viewModel.typeColor())
            
            VStack(spacing: 20) {
                if let detail = viewModel.pokemonDetail {
                    // Animated Image Load
                    AsyncImage(url: detail.imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .scaleEffect(1.1)
                                .transition(.scale.combined(with: .opacity))
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                        @unknown default:
                            EmptyView()
                        }
                    }

                    Text(detail.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(.white)

                    // Information Grid
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Height: \(detail.height)")
                            Text("Weight: \(detail.weight)")
                            Text("Types: \(detail.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                            Text("Abilities:")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(detail.abilities, id: \.ability.name) { ability in
                                Text(ability.ability.name.capitalized)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .transition(.slide)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(viewModel.typeColor().opacity(0.7))
                    )
                } else {
                    ProgressView("Loading...")
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .task {
            await viewModel.loadPokemonDetail(url: pokemonUrl)
        }
    }
}
