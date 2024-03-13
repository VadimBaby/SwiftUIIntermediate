//
//  aboutInflect.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 21.10.2023.
//

import SwiftUI

struct aboutInflect: View {
    
    @State private var count: Int = 1
    
    var body: some View {
        VStack {
            Button("Add", action: { count += 1 })
            Button("Remove", action: { count -= 1 })
            Text("^[\(count) person](inflect: true)")
        }
    }
}

#Preview {
    aboutInflect()
}
