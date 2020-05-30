//
//  Helper.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 28/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension String {
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        let data: Data = self.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let _object = try decoder.decode(type, from: data)
            return _object
        } catch {
            return nil
        }
    }
}

func getDummyDataObject() -> Pokemon {
    let dummyDataString = "{\"id\":37,\"num\":\"037\",\"name\":\"Vulpix\",\"img\":\"http://www.serebii.net/pokemongo/pokemon/037.png\",\"type\":[\"Fire\"],\"height\":\"0.61 m\",\"weight\":\"9.9 kg\",\"candy\":\"Vulpix Candy\",\"candy_count\":50,\"egg\":\"5 km\",\"spawn_chance\":0.22,\"avg_spawns\":22,\"spawn_time\":\"13:43\",\"multipliers\":[2.74,2.81],\"weaknesses\":[\"Water\",\"Ground\",\"Rock\"],\"next_evolution\":[{\"num\":\"038\",\"name\":\"Ninetales\"}]}"
    
    return dummyDataString.parse(to: Pokemon.self)!
}
