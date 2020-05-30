//
//  PokemonTypeView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 28/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct PokemonTypeView: View {
    private var type: String
    init(type: String) {
        self.type = type
    }
    var body: some View {
        Text(type)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding([.leading, .trailing], 10)
            .padding(.bottom, 10)
            .background(
                Capsule()
                    .fill(Color.white)
                    .opacity(0.25)
                    .frame(height: 25).padding([.bottom], 10))
    }
}

struct PokemonTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeView(type: "Fire")
    }
}
