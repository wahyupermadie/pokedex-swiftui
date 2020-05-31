//
//  BottomSheetView.swift
//  PokemonApp
//
//  Created by Wahyu Permadi on 31/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI


private enum BottomSheetViewConstant {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}

struct BottomSheetView<Content: View>: View {
    @State var isOpen: Bool? = false

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    var safeAreaHeigh: CGFloat = 0
    private var isExpandabled: Bool = false
    
    @GestureState private var translation: CGFloat = 0
    
    init(isExpandabled: Bool, safeAreaHeigh: CGFloat, isOpen: Bool, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * BottomSheetViewConstant.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self.isOpen = isOpen
        self.safeAreaHeigh = safeAreaHeigh
        self.isExpandabled = isExpandabled
    }
    
    private var offset: CGFloat {
        isOpen! ? self.safeAreaHeigh : maxHeight - minHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: BottomSheetViewConstant.radius)
            .fill(Color.secondary)
            .frame(
                width: BottomSheetViewConstant.indicatorWidth,
                height: BottomSheetViewConstant.indicatorHeight
        ).onTapGesture {
            self.isOpen!.toggle()
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(BottomSheetViewConstant.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            if self.isExpandabled {
                self.gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }.onEnded { value in
                        let snapDistance = self.maxHeight * BottomSheetViewConstant.snapRatio
                        guard abs(value.translation.height) > snapDistance else {
                            return
                        }
                        
                        self.isOpen = value.translation.height < 0
                    }
                )
            }
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BottomSheetView(isExpandabled: false, safeAreaHeigh: geometry.safeAreaInsets.top, isOpen: true, maxHeight: 600){
                Rectangle().fill(Color.red)
            }
        }
    }
}
