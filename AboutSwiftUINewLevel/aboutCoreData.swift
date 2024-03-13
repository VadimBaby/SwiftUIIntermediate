//
//  aboutCoreData.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 28.04.2023.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var saveEntities: [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "Fruit")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits(){
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do{
            let entities = try container.viewContext.fetch(request)
            saveEntities = entities.sorted(by: {$0.createdData ?? Date() > $1.createdData ?? Date()})
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        entity.name = currentName + "!"
        
        saveContext()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = saveEntities[index]
        container.viewContext.delete(entity)
        
        saveContext()
    }
    
    func addFruit(fruit: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = fruit
        newFruit.createdData = Date()
        
        saveContext()
    }
    
    func saveContext(){
        do{
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error: \(error)")
        }
    }
}

struct aboutCoreData: View {
    @StateObject var vm = CoreDataViewModel()
    
    @State var fruitTextField: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    TextField("Fruit", text: $fruitTextField)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .padding(.leading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    Button(action: {
                        if !fruitTextField.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            withAnimation(.linear){
                                vm.addFruit(fruit: fruitTextField)
                            }
                            fruitTextField = ""
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.teal)
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
                List{
                    ForEach(vm.saveEntities) { entity in
                        Text(entity.name ?? "")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct aboutCoreData_Previews: PreviewProvider {
    static var previews: some View {
        aboutCoreData()
    }
}
