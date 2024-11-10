//
//  ContentView.swift
//  PokeDex
//
//  Created by Thomas Garayua on 11/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokemonListViewModel()
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding([.leading, .trailing])

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredPokemonList) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemonUrl: pokemon.url)) {
                                PokemonGridItemView(pokemon: pokemon)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                    .animation(.spring(), value: filteredPokemonList)
                }
            }
            .navigationTitle("PokéDex")
            .task {
                await viewModel.loadData()
            }
        }
    }

    var filteredPokemonList: [PokemonListItem] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
