//
//  PokemonItem.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 27/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct PokemonItem: View {
    private var pokemon: Pokemon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    var body: some View {
        ZStack {
            PokemonBackgroundView(pokemonType: pokemon.type[0].rawValue)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    ZStack{
                        Image("pokeball")
                            .resizable()
                            .foregroundColor(.white)
                            .opacity(0.10)
                            .position(x: 80, y: 70)
                            .frame(width: (UIScreen.main.bounds.width - 20) / 3, height: (UIScreen.main.bounds.width - 20) / 3)
                            .clipped()
                        PokemonImageView(pokemonImageUrl: pokemon.img)
                    }
                }
            }
            
            HStack {
                VStack {
                    Spacer()
                    ForEach(pokemon.type, id: \.self) { (type: TypeElement) in
                        PokemonTypeView(type: type.rawValue)
                    }
                    Spacer()
                }.padding([.leading, .top], 10)
                Spacer()
            }
            
            HStack{
                VStack(alignment: .leading){
                    Text(pokemon.name)
                        .fontWeight(.bold)
                        .frame(alignment: .topLeading)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .padding(.leading, 10)
                    Spacer()
                }
                Spacer()
            }
        }.frame(width: (UIScreen.main.bounds.width - 30) / 2, height: (UIScreen.main.bounds.width - 30) / 2)
    }
}

struct PokemonBackgroundView: View {
    var color: Color?
    init(pokemonType: String) {
        switch pokemonType {
        case TypeElement.grass.rawValue:
            self.color = ColorManager.pokemonGreen
        case TypeElement.water.rawValue:
            self.color = ColorManager.pokemonBlue
        case TypeElement.fire.rawValue:
            self.color = ColorManager.pokemonRed
        case TypeElement.poison.rawValue:
            self.color = ColorManager.pokemonPurple
        case TypeElement.ground.rawValue:
            self.color = ColorManager.pokemonBrown
        default:
            self.color = ColorManager.pokemonYellow
        }
    }
    var body: some View {
        Rectangle()
            .foregroundColor(color ?? Color(hex: "41c7a9"))
            .frame(width: (UIScreen.main.bounds.width - 30) / 2, height: (UIScreen.main.bounds.width - 30) / 2)
            .cornerRadius(5)
            .shadow(radius: 5)
    }
}

struct PokemonImageView : View {
    @ObservedObject var pokemonVm = PokemonViewModel()
    private var pokemonImageUrl: String
    @State private var animationAmount: CGFloat = 1
    init(pokemonImageUrl: String) {
        self.pokemonImageUrl = pokemonImageUrl
    }
    var body: some View {
        ZStack {
            if self.pokemonVm.image != nil {
                Image(uiImage: pokemonVm.image!)
                    .resizable()
                    .renderingMode(.original)
            }else{
                Image("pokeballcolor")
                    .resizable()
                    .renderingMode(.original)
                    .scaleEffect(animationAmount)
                    .animation(
                        Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                    ).frame(
                        width: (UIScreen.main.bounds.width)/10,
                        height: (UIScreen.main.bounds.width)/10
                    )
            }
        }.onAppear {
            self.animationAmount = 2
            self.pokemonVm.getPokemonImage(from: URL(string: self.pokemonImageUrl)!)
        }
        .position(x: 70, y: (UIScreen.main.bounds.width - 20)/5)
        .frame(
            width: (UIScreen.main.bounds.width)/3,
            height: (UIScreen.main.bounds.width)/3
        ).clipped()
    }
}

struct PokemonItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItem(pokemon: getDummyDataObject())
    }
}
