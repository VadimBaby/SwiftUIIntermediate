//
//  aboutMultiplySheets.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 21.04.2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}


// 1 - binding

struct aboutMultiplySheets: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
                showSheet.toggle()
            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: $selectedModel)
        }
    }
}

struct NextScreen: View {
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct aboutMultiplySheets_Previews: PreviewProvider {
    static var previews: some View {
        aboutMultiplySheets()
    }
}
