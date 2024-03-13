//
//  aboutMultiplySheets3.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 21.04.2023.
//

import SwiftUI

// 3 - $item

struct aboutMultiplySheets3: View {
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
            }
        }
        .sheet(item: $selectedModel) { model in
            NextScreen3(selectedModel: model)
        }
    }
}

struct NextScreen3: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct aboutMultiplySheets3_Previews: PreviewProvider {
    static var previews: some View {
        aboutMultiplySheets3()
    }
}
