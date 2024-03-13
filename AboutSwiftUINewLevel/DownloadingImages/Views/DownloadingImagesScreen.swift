//
//  DownloadingImagesScreen.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 31.05.2023.
//

import SwiftUI

struct DownloadingImagesScreen: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(vm.dataArray){ model in
                    DownloadingImagesRow(model: model)
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesScreen()
    }
}
