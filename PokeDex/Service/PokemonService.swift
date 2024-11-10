//
//  PokemonService.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import Foundation

class PokemonService {
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    func fetchPokemonList(limit: Int = 99999) async throws -> [PokemonListItem] {
        guard let url = URL(string: "\(baseUrl)?limit=\(limit)") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
        return pokemonResponse.results
    }
    
    func fetchPokemonDetail(url: String) async throws -> PokemonDetail {
        guard let detailUrl = URL(string: url) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: detailUrl)
        let pokemonDetailResponse = try JSONDecoder().decode(PokemonDetail.self, from: data)
        return pokemonDetailResponse
    }
}
