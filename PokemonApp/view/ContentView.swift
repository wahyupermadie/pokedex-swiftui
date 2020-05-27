//
//  ContentView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 27/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI
import ShimmerView

struct ContentView: View {
    var shouldShimmer: Bool = true
    var body: some View {
        VStack {
            PokemonItem()
        }
        .padding()
    }
}

#if DEBUG
struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
