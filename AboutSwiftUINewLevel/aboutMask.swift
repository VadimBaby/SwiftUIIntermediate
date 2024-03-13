//
//  aboutMask.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 21.04.2023.
//

import SwiftUI

struct aboutMask: View {
    @State var rating: Int = 0
    var body: some View {
        ZStack {
            startView
                .overlay {
                    overlayView
                        .mask(startView)
                }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geomentry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: CGFloat(rating) / 5 * geomentry.size.width)
            }
        }
        .allowsHitTesting(false) // this view dont clicked
    }
    
    private var startView: some View {
        HStack{
            ForEach(1..<6){ index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
        }
    }
}

struct aboutMask_Previews: PreviewProvider {
    static var previews: some View {
        aboutMask()
    }
}
