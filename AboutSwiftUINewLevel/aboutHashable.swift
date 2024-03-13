//
//  aboutHashable.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 25.04.2023.
//

import SwiftUI

struct MyStruckIdentifiable: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MyStruckHashable: Hashable {
    let title: String
    let subtitle: String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle)
    }
}

struct aboutHashable: View {
    
    let dataIdentifiable: [MyStruckIdentifiable] = [
        MyStruckIdentifiable(title: "ONE"),
        MyStruckIdentifiable(title: "TWO"),
        MyStruckIdentifiable(title: "THREE"),
        MyStruckIdentifiable(title: "FOUR"),
        MyStruckIdentifiable(title: "FIVE")
    ]
    
    let dataHashable: [MyStruckHashable] = [
        MyStruckHashable(title: "one".uppercased()),
        MyStruckHashable(title: "two".uppercased()),
        MyStruckHashable(title: "three".uppercased()),
        MyStruckHashable(title: "four".uppercased()),
        MyStruckHashable(title: "five".uppercased())
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40){
                ForEach(dataIdentifiable) { item in
                    Text(item.title)
                        .font(.headline)
                }
                
                ForEach(dataHashable, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

struct aboutHashable_Previews: PreviewProvider {
    static var previews: some View {
        aboutHashable()
    }
}
