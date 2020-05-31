//
//  ProfileView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 30/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 10)
                .frame(width: 250, height: 250)
            Text("I Putu Wahyu Permadi")
            Text("wahyu.permadi1725@gmail.com")
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
