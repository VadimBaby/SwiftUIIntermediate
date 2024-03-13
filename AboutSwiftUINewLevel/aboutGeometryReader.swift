//
//  aboutGeometryReader.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 20.04.2023.
//

import SwiftUI

struct aboutGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in // geometryReader is heavy and it do the app slow, so if you can dont use geometryReader then dont use it
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width * 0.6666)
                Rectangle()
                    .fill(Color.blue)
            }
            .ignoresSafeArea()
        }
    }
}

struct aboutGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        aboutGeometryReader()
    }
}
