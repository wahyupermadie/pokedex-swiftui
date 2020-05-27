//
//  ShimmerView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 27/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ShimmerView: View {
    
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.15
        static let maxOpacity: Double = 0.5
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    init () {}
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.gray)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
        }
    }
}

struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
         VStack {
           ShimmerView()
               .frame(width: 100, height: 100)
           
           ShimmerView()
               .frame(height: 20)
           
           ShimmerView()
               .frame(height: 20)
           
           ShimmerView()
               .frame(height: 100)
           
           ShimmerView()
               .frame(height: 50)
           
           ShimmerView()
               .frame(height: 20)
           
           ShimmerView()
               .frame(height: 100)
           
           ShimmerView()
               .frame(height: 50)
           
           ShimmerView()
               .frame(height: 20)
       }
       .padding()
   }
}
