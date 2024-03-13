//
//  aboutDownloadWithCombine.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWIthCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    var cancelable = Set<AnyCancellable>()
    
    init() {
        getPost()
    }
    
    func getPost(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. recieve the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!!
        // 7. cancellable at any time!!
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        
        // it will be running every time whem will publish new data
        URLSession.shared.dataTaskPublisher(for: url)
        // dataTaslPublisher автомически выполняется в backgroundThread поэтому строчка ниже нам не нужна
           // .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
        // TryMap is a Map that can fail and throw an error.
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancelable)

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct aboutDownloadWithCombine: View {
    @StateObject var vm = DownloadWIthCombineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { item in
                VStack(alignment: .leading){
                    Text(item.title)
                        .font(.title)
                    Text(item.body)
                        .foregroundColor(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct aboutDownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        aboutDownloadWithCombine()
    }
}
