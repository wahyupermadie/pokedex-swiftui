//
//  PokemonItem.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 27/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct PokemonItem: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(hex: "41c7a9"))
                .frame(width: (UIScreen.main.bounds.width - 30) / 2, height: (UIScreen.main.bounds.width - 30) / 2)
                .cornerRadius(5)
                .shadow(radius: 5)
            HStack {
                VStack {
                    Spacer()
                    ForEach(0 ..< 2) { number in
                        Text("Fire")
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
                    Spacer()
                }.padding(.leading, 5)
                
                VStack {
                    Spacer()
                    ZStack{
                        Image("pokeball")
                            .resizable()
                            .foregroundColor(.white)
                            .opacity(0.10)
                            .frame(width: (UIScreen.main.bounds.width - 20) / 4, height: (UIScreen.main.bounds.width - 20) / 4)
                        Image("bulbasur")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: (UIScreen.main.bounds.width) / 4, height: (UIScreen.main.bounds.width) / 4)
                    }
                }
            }
            HStack{
                VStack(alignment: .leading){
                    Text("Bulbasur")
                        .fontWeight(.bold)
                        .frame(alignment: .topLeading)
                        .font(.title)
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

struct PokemonItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItem()
    }
}
