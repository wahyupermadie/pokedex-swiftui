//
//  DetailPokemonView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 30/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct DetailPokemonView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var heartIcon : String = "heart"
    @ObservedObject var pokemonVm = PokemonViewModel()
    private var pokemon: Pokemon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(ColorManager.pokemonBrown)
            GeometryReader { geomerty in
                VStack {
                    HStack {
                        Text(self.pokemon.name)
                            .font(.title)
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("#\(self.pokemon.num)")
                            .foregroundColor(Color.white)
                    }.padding([.leading, .trailing, .top], 20)
                    HStack{
                        ForEach(self.pokemon.type, id: \.self) { (type: TypeElement) in
                            PokemonTypeView(type: type.rawValue)
                        }
                        Spacer()
                        Text(self.pokemon.candy)
                            .foregroundColor(Color.white)
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    ImgCurrentPokemon(pokemonUrl: self.pokemon.img)
                    
                    PokemonBodyInfo(weight: self.pokemon.weight, height: self.pokemon.height)
                    
                    BottomSheetView(
                        isExpandabled: false,
                        safeAreaHeigh: geomerty.safeAreaInsets.top * 0.5,
                        isOpen: false,
                        maxHeight: UIScreen.screenHeight - 45){
                        HStack {
                            VStack {
                                Text("Previous Evolution")
                                if self.pokemon.prevEvolution != nil {
                                    PokemonImage(pokemonUrl: self.pokemon.prevEvolution![0].num)
                                }else{
                                    Text("Evolution Not Found")
                                        .font(.title)
                                }
                            }
                            Spacer()
                            VStack {
                                Text("Next Evolution")
                                if self.pokemon.nextEvolution != nil {
                                    PokemonImage(pokemonUrl: self.pokemon.nextEvolution![0].num)
                                }else{
                                    Text("Evolution Not Found")
                                        .font(.title)
                                }
                            }
                        }
                        .padding(.top, 15)
                        .padding([.leading, .trailing], 20)
                    }
                }.padding(.top, geomerty.safeAreaInsets.top * 0.5)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                },
            trailing:
                Button(action: {
                    self.heartIcon = "heart.fill"
                }) {
                    Image(systemName: heartIcon)
                }
        )
    }
}

struct PokemonImage: View {
    private var pokemonUrl: String
    @ObservedObject var pokemonVm = PokemonViewModel()
    init(pokemonUrl: String) {
        self.pokemonUrl = "http://www.serebii.net/pokemongo/pokemon/\(pokemonUrl).png"
    }
    var body: some View {
        VStack {
            if pokemonVm.image != nil {
                Image(uiImage: pokemonVm.image!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(
                        width: UIScreen.main.bounds.width/3,
                        height: UIScreen.main.bounds.height/5
                    )
            }
        }.onAppear {
            self.pokemonVm.getPokemonImage(from: URL(string: self.pokemonUrl)!)
        }
    }
}
struct PokemonBodyInfo: View {
    private var weight: String
    private var height: String
    init(weight: String, height: String) {
        self.weight = weight
        self.height = height
    }
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Text("Height")
                    .foregroundColor(Color.white)
                Text(self.height)
            }
            Spacer()
            VStack(spacing: 5){
                Text("Weight")
                    .foregroundColor(Color.white)
                Text(self.weight)
            }
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 20)
        .background(Color.white.opacity(0.4))
        .cornerRadius(8)
        .padding([.leading, .trailing], 40)
        .padding(.top, 5)
        .shadow(radius: 5)
    }
}

struct ImgCurrentPokemon: View {
    @ObservedObject var pokemonVm = PokemonViewModel()
    private var pokemonUrl: String
    init(pokemonUrl: String) {
        self.pokemonUrl = pokemonUrl
    }
    var body: some View {
        ZStack {
            Image("pokeball")
                .resizable()
                .foregroundColor(.white)
                .opacity(0.10)
                .frame(width: (UIScreen.screenWidth + 40) / 2, height: (UIScreen.screenHeight - 30) / 3)
            if pokemonVm.image != nil {
                Image(uiImage: self.pokemonVm.image!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: UIScreen.screenWidth / 2, height: UIScreen.screenHeight / 3)
            }
        }.onAppear {
            self.pokemonVm.getPokemonImage(from: URL(string: self.pokemonUrl)!)
        }
    }
}
struct DetailPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPokemonView(pokemon: getDummyDataObject())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.left")
                },
            trailing:
                Button(action: {
                    
                }) {
                    Image(systemName: "heart")
                }
        )
    }
}
