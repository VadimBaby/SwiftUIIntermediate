//
//  aboutEscaping.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 04.05.2023.
// 

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Data"
    
    func getData() {
        downloadData4 { [weak self] returnedData in
            self?.text = returnedData.data
        }
    }
    
    func downloadData() -> String {
        return "New Data"
    }
    
    func downloadData2(complitionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            complitionHandler("New Data")
        }
    }
    
    func downloadData3(complitionHandler: @escaping (_ data: DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let result = DownloadResult(data: "New Data")
            complitionHandler(result)
        }
    }
    
    func downloadData4(complitionHandler: @escaping DownloadComplition) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let result = DownloadResult(data: "New Data")
            complitionHandler(result)
        }
    }
}

typealias DownloadComplition = (_ data: DownloadResult) -> Void

struct DownloadResult {
    let data: String
}

struct aboutEscaping: View {
    
    @StateObject var vm: EscapingViewModel = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .foregroundColor(Color.blue)
            .bold()
            .onTapGesture {
                vm.getData()
            }
    }
}

struct aboutEscaping_Previews: PreviewProvider {
    static var previews: some View {
        aboutEscaping()
    }
}
