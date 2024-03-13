//
//  aboutCodable.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 11.05.2023.
//

import SwiftUI

// Codable = Decodable + Encodable

struct CustomerModel: Identifiable, Codable /* Decodable, Encodable */ {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
        
    // когда мы используем Codable, нам не обязательно писать все что относиться к Decodable и Encodable (это все что ниже)
    
    // enum ключей, сам enum должен быть равен переменной, в которую будет заноситься значение, а rawValue типа String равно ключу в JSON типа Data из которого будет браться значение
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium = "is_premium"
//    }
//
//    // базовый init (нужен прописать так как будет еще один init)
//
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    // init для Decodable,
//
//    init(from decoder: Decoder) throws {
//
//        // создаем decoder container с ключами CodingKeys
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        // просто декодируем значения для каждого ключа из CodingKeys в определенный тип и присваиваем нужной переменной
//
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    // функция encode для Encodable
//
//    func encode(to encoder: Encoder) throws {
//        // создаем encoder container с ключами CodingKeys
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        // индекодируем значения из определенного ключа в определенную переменную
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init(){
        getData()
    }
    
    func getData() {
        // получаем data из getJSONDate
        guard let data = getJSONDate() else { return }
        
        // пробуем декодировать значения data в тип CustomerModel.self
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
//        do{
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print("Error: \(error)")
//        }
    }
    
    func getJSONDate() -> Data? {
        // создаем экземляр customer
        let customer = CustomerModel(id: "123", name: "Alex", points: 12, isPremium: true)
        
        // простно индекодируем customer
        let jsonData = try? JSONEncoder().encode(customer) // в переменную jsonData получаем JSON объект типа Data с данными customer
        
        return jsonData
    }
}

struct aboutCodable: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct aboutCodable_Previews: PreviewProvider {
    static var previews: some View {
        aboutCodable()
    }
}
