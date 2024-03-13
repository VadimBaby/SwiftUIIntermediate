//
//  aboutMultiplySheets2.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 21.04.2023.
//

import SwiftUI

// 2 - multiply sheets

struct aboutMultiplySheets2: View {
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet) {
                NextScreen2(selectedModel: RandomModel(title: "ONE"))
            }
            
            Button("Button 2") {
                showSheet2.toggle()
            }
            .sheet(isPresented: $showSheet2) {
                NextScreen2(selectedModel: RandomModel(title: "TWO"))
            }
        }
    }
}

struct NextScreen2: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct aboutMultiplySheets2_Previews: PreviewProvider {
    static var previews: some View {
        aboutMultiplySheets2()
    }
}
