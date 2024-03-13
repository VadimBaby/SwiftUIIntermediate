//
//  aboutBackgroundThread.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 01.05.2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData(){
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData() // do it in background
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData // do it in main
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for i in 0..<100 {
            data.append(String(i))
        }
        
        return data
    }
}

struct aboutBackgroundThread: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 20) {
                Text("Load Data".uppercased())
                    .font(.largeTitle)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .foregroundColor(Color.red)
                        .font(.headline)
                }
            }
        }
    }
}

struct aboutBackgroundThread_Previews: PreviewProvider {
    static var previews: some View {
        aboutBackgroundThread()
    }
}
