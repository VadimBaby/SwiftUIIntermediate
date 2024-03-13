//
//  aboutRotationGesture.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 11.04.2023.
//

import SwiftUI

struct aboutRotationGesture: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        // on simulator press option and change the rotation of text
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color.white)
            .padding(10)
            .background(Color.blue.cornerRadius(15))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        withAnimation(.spring()){
                            angle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

struct aboutRotationGesture_Previews: PreviewProvider {
    static var previews: some View {
        aboutRotationGesture()
    }
}
