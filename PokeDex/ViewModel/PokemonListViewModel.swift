//
//  PokemonListViewModel.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import Foundation

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    private let service = PokemonService()
    
    func loadData() async {
        do {
            pokemonList = try await service.fetchPokemonList()
            print("--> pokemonList: \(pokemonList)")
        } catch {
            print("Error loading pokemon list PokemonListViewModel: ", error.localizedDescription)
        }
    }
}
