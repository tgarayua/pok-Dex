//
//  Pokemon.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import Foundation

struct PokemonResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable, Equatable {
    var id: String { url }
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]
    let types: [TypeElement]

    var imageURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }

    struct Ability: Codable {
        let ability: NamedResource
    }

    struct TypeElement: Codable {
        let type: NamedResource
    }

    struct NamedResource: Codable {
        let name: String
    }
}

