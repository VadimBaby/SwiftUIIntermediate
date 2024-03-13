//
//  aboutGeometryReader2.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 20.04.2023.
//

import SwiftUI

struct aboutGeometryReader2: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
}

struct aboutGeometryReader2_Previews: PreviewProvider {
    static var previews: some View {
        aboutGeometryReader2()
    }
}
