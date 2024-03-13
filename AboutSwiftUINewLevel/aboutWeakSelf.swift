//
//  aboutWeakSelf.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 01.05.2023.
// https://www.youtube.com/watch?v=TPHp9kR0Go8&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=19


import SwiftUI

struct aboutWeakSelf: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationStack{
            NavigationLink("Second Screen", destination: SecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct SecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            
            if let data = vm.data {
                Text(data)
                    .font(.largeTitle)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        print("INITIALIZE NOW")
        getData()
    }
    
    deinit{
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
        print("DEINITIALIZE NOW")
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            //self.data = "NEW DATA!!!" // this self means this class should be alive while this func completing
            
            self?.data = "NEW DATA!!!"
        }
    }
}

struct aboutWeakSelf_Previews: PreviewProvider {
    static var previews: some View {
        aboutWeakSelf()
    }
}
