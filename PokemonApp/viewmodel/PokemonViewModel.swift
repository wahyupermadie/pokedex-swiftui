//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 28/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import UIKit

protocol IPokemonViewModel {
    func getPokemon()
    func getPokemonImage(from imageUrl: URL)
}

class PokemonViewModel: IPokemonViewModel, ObservableObject {
    @Published var isLoading: Bool = true
    @Published var pokemons: [Pokemon]? = []
    @Published var image: UIImage? = nil
    
    private let pokemonRepository: IPokemonRepository
    init(pokemonRepository: IPokemonRepository = PokemonRepository.instance) {
        self.pokemonRepository = pokemonRepository
    }
    
    func getPokemon() {
        self.isLoading = true
        pokemonRepository.fetchPokemon(successHandler: { (data) in
            self.pokemons = data.pokemon
            self.isLoading = false
        }) { (error) in
            self.isLoading = false
            print(error)
        }
    }
    
    func getPokemonImage(from imageUrl: URL) {
        pokemonRepository.fetchPokemonImage(from: imageUrl, successHandler: { (data) in
            self.image = data
        }) { (err) in
            print(err)
        }
    }
}
