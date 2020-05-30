//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 29/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import UIKit

protocol IPokemonRepository {
    func fetchPokemon(successHandler: @escaping(_ response: PokemonResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchPokemonImage(successHandler: @escaping(_ response: UIImage) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}
class PokemonRepository: IPokemonRepository {
    static let instance: IPokemonRepository = PokemonRepository()
    private static let cache = NSCache<AnyObject, AnyObject>()
    private let urlSession: URLSession = URLSession.shared
    
    func fetchPokemon(successHandler: @escaping (PokemonResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        let url = URL(string: Constants.BASE_URL)
        urlSession.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                errorHandler(error!)
            }
            do {
                let pokemons = try JSONDecoder().decode(PokemonResponse.self, from: data!)
                DispatchQueue.main.async {
                    successHandler(pokemons)
                }
            } catch {
                DispatchQueue.main.async {
                    errorHandler(error)
                }
            }
        }.resume()
    }
    
    func fetchPokemonImage(successHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        
    }
    
    
}
