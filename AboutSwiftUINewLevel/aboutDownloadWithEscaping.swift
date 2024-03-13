//
//  aboutDownloadWithEscaping.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 13.05.2023.
//

import SwiftUI

// https://app.quicktype.io - parse json data to struct

struct DataModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscaping: ObservableObject {
    @Published var user: DataModel? = nil
    
    init() {
        getPost()
    }
    
    func getPost(){
        
        // создаем url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        downloadData(fromUrl: url) { returnedData in
            // проверяем data на nil
            if let data = returnedData {
                // декодируем data в тип DataModel
                guard let newPost = try? JSONDecoder().decode(DataModel.self, from: data) else { return }
                
                // присваиваем переменной user нашу декодируемую data в main thread
                DispatchQueue.main.async { [weak self] in
                    // данная код выполняется в main thread
                    self?.user = newPost
                }
            } else {
                print("No returned data")
            }
        }
    }
    
    func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        // делаем запрос
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // проверяем на успешный ответ
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 // проверка на успешный statusCode
            else {
                print("Error downloading data")
                // ызываем completionHandler с аргументом nil
                completionHandler(nil)
                return
            }
            // если все успешно, то вызываем completionHandler с аргументом data
            completionHandler(data)
            
        }.resume() // .resume() - означает выполнение запроса, просто используем .resume() just to start it
    }
}

struct aboutDownloadWithEscaping: View {
    @StateObject var vm = DownloadWithEscaping()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            if let user = vm.user {
                Text("\(user.userId)")
                Text("\(user.id)")
                Text("\(user.title)")
                Text("\(user.body)")
            }
        }
    }
}

struct aboutDownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        aboutDownloadWithEscaping()
    }
}
