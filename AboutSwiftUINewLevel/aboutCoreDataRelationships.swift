//
//  aboutCoreDataRelationships.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 01.05.2023.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do{
            try context.save()
            print("Save Successfully")
        } catch let error {
            print("Error save: \(error)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@",
//        "Apple")
//
//        request.predicate = filter
        
        do{
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do{
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do{
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getEmployeesForBusiness(forBusiness business: BusinessEntity){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate( format: "business == %@", business)
        request.predicate = filter
        
        do{
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func addBusiness(){
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Sony"
        
       // newBusiness.addToDepartments(departments[1])
       // newBusiness.addToEmployees(employees[1])
        
        newBusiness.departments = [departments[0], departments[1]]
        newBusiness.employees = [employees[0], employees[1]]
        
        save()
    }
    
    func addDepartments(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Enginer"
       // newDepartment.businesses = [businesses[0]]
        
        newDepartment.addToEmployees(employees[1])
        
        save()
    }
    
    func addEmployees(){
        let newEmployees = EmployeeEntity(context: manager.context)
        newEmployees.name = "Emily"
        newEmployees.age = 25
        newEmployees.dateJoined = Date()
        
        //newEmployees.business = businesses[0]
        //newEmployees.department = departments[0]
        
        save()
    }
    
    func deleteDepartment(){
        let department = departments[1]
        manager.context.delete(department)
        
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        })
    }
}

struct aboutCoreDataRelationships: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20) {
                    HStack{
                        Button(action: {
                            vm.addBusiness()
                        }) {
                            Text("Add Business")
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                                .frame(height: 55)
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            vm.addDepartments()
                        }) {
                            Text("Add Department")
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                                .frame(height: 55)
                                .background(Color.green)
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            vm.addEmployees()
                        }) {
                            Text("Add Employee")
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                                .frame(height: 55)
                                .background(Color.red)
                                .cornerRadius(15)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct aboutCoreDataRelationships_Previews: PreviewProvider {
    static var previews: some View {
        aboutCoreDataRelationships()
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments")
                    .bold()
                
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses")
                    .bold()
                
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
                .bold()
            
            Text("Date Joined: \(entity.dateJoined ?? Date())")
                .bold()
            
            Text("Business:")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            Text("Department:")
            
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
