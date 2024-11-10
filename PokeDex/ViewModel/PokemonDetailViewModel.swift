//
//  PokemonDetailViewModel.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import SwiftUI

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    private let service = PokemonService()
    
    func loadPokemonDetail(url: String) async {
        do {
            pokemonDetail = try await service.fetchPokemonDetail(url: url)
        } catch {
            print("Failed to load Pokemon Detail: ", error.localizedDescription)
        }
    }
    
    func typeColor() -> Color {
        guard let typeName = pokemonDetail?.types.first?.type.name else { return .gray }
        switch typeName.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        default: return .gray
        }
    }
}
