//
//  aboutTypelias.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 03.05.2023.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct aboutTypelias: View {
    
    @State var item: TVModel = TVModel(title: "TV Title", director: "Emily", count: 5)
    
    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director)
            Text("Count: \(item.count)")
        }
    }
}

struct aboutTypelias_Previews: PreviewProvider {
    static var previews: some View {
        aboutTypelias()
    }
}
