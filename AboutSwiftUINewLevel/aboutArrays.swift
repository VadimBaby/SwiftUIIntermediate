//
//  aboutArrays.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 25.04.2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        getFilteredArray()
        getMappedArray()
    }
    
    func getMappedArray() {
//        mappedArray = filteredArray.map({ (user) -> String in
//            return user.name
//        })
        mappedArray = filteredArray.map{$0.name}
        
//        mappedArray = filteredArray.compactMap({ user in
//            return user.name
//        }) we can call compactMap when user.name can be nil and in this case we can dont pass default value if user.name is nil, and just miss it. In map we have to pass default value if user.name is nil
    }
    
    func getFilteredArray() {
        
        // sort
        
//        filteredArray = dataArray.sorted(by: { user1, user2 in
//            return user1.point > user2.point
//        })
        
       // filteredArray = dataArray.sorted(by: {$0.point > $1.point})
        
        // filter
        
        //filteredArray = dataArray.filter{$0.point > 40}
        
        filteredArray = dataArray.sorted(by: {$0.point > $1.point})
            .filter{$0.isVerified}
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Vadim", point: 200, isVerified: true)
        let user2 = UserModel(name: "Alexey", point: 12, isVerified: false)
        let user3 = UserModel(name: "Sosnov", point: 34, isVerified: true)
        let user4 = UserModel(name: "Yasha", point: 11, isVerified: true)
        let user5 = UserModel(name: "Zagar", point: 1, isVerified: false)
        let user6 = UserModel(name: "Brixton a.k. big ass", point: 19, isVerified: true)
        let user7 = UserModel(name: "Romanus", point: 67, isVerified: false)
        let user8 = UserModel(name: "Shlyapa", point: 49, isVerified: false)
        let user9 = UserModel(name: "Crip", point: 37, isVerified: true)
        let user10 = UserModel(name: "Utkonos", point: 28, isVerified: false)
        dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
}

struct aboutArrays: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 10){
                    ForEach(vm.filteredArray) { user in
                        HStack {
                            VStack(alignment: .leading){
                                Text(user.name)
                                    .foregroundColor(Color.white)
                                Text("Points: \(user.point)")
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                            
                            if user.isVerified {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Open") {
                        MappedArrayView(vm: vm)
                    }
                }
            }
        }
    }
}

struct MappedArrayView: View {
    @ObservedObject var vm: ArrayModificationViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                ForEach(vm.mappedArray, id: \.self) { user in
                    Text(user)
                        .font(.title)
                }
            }
        }
    }
}

struct aboutArrays_Previews: PreviewProvider {
    static var previews: some View {
        aboutArrays()
    }
}
