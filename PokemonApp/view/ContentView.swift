//
//  ContentView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 27/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var pokemonViewModel : PokemonViewModel = PokemonViewModel()
    @State var Grid: [Int] = []
    
    var shouldShimmer: Bool = true
    var body: some View {
        NavigationView{
            ZStack {
                if !pokemonViewModel.isLoading {
                    VStack {
                        if !self.Grid.isEmpty {
                            ScrollView(.vertical, showsIndicators: false){
                                ForEach(self.Grid, id: \.self){ i in
                                    HStack(spacing: 15){
                                        ForEach(i...i+1, id: \.self) { (j: Int) in
                                            NavigationLink(destination: DetailPokemonView(pokemon: self.pokemonViewModel.pokemons![j])){
                                                PokemonItem(pokemon: self.pokemonViewModel.pokemons![j])
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }.onAppear {
                        self.generateGrid()
                    }
                }else{
                    ScrollView(.vertical, showsIndicators: false) {
                        PokemonShimmer()
                        PokemonShimmer()
                        PokemonShimmer()
                    }
                }
            }.navigationBarTitle(
                Text("Dex Pokemon")
            )
            .navigationViewStyle(StackNavigationViewStyle()).navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: ProfileView()){
                        Image(systemName: "person")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 25, height: 25)
                    }
                }
            )
        }
        .onAppear(perform: {
            self.pokemonViewModel.getPokemon()
        })
        .onDisappear {
            self.pokemonViewModel.pokemons?.removeAll()
        }
    }
    
    func generateGrid(){
        self.Grid.removeAll()
        for i in stride(from: 0, to: self.pokemonViewModel.pokemons!.count-1, by: 2){
            self.Grid.append(i)
        }
    }
}

#if DEBUG
struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
