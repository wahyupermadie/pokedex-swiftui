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
    func fetchPokemonImage(from imageUrl: URL, successHandler: @escaping(_ response: UIImage) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
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
    
    func fetchPokemonImage(from imageUrl: URL, successHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        if let fromCache = PokemonRepository.cache.object(forKey: imageUrl as AnyObject) as? UIImage {
            successHandler(fromCache)
            return
        }
        
        urlSession.dataTask(with: imageUrl) { (data, res, err) in
            if err != nil {
                errorHandler(err!)
                return
            }
            
            guard let image = UIImage(data: data!) else {
                return
            }
            
            PokemonRepository.cache.setObject(image, forKey: imageUrl as AnyObject)
            DispatchQueue.main.async {
                successHandler(image)
            }
            
        }.resume()
    }
    
    
}
