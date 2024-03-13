//
//  aboutMagnificationGesture.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 11.04.2023.
//

import SwiftUI

struct aboutMagnificationGesture: View {
    
    @State var currentAmount: CGFloat = 0
    
    var body: some View {
        // on simulator press option and change the scale of image
        
        VStack(spacing: 10) {
            HStack{
                Circle()
                    .frame(width: 35, height: 35)
                Text("SWiftUI Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.spring()){
                                currentAmount = 0
                            }
                        })
                )
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo!")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct aboutMagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        aboutMagnificationGesture()
    }
}
