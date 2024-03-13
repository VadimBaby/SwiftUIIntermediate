//
//  aboutCache.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 21.05.2023.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String){
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    
    let imageName: String = "21"
    
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
        getFromCache()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
}

struct aboutCache: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack{
                    Button(action: {
                        vm.saveToCache()
                    }) {
                        Text("Save To Cache")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        vm.removeFromCache()
                    }) {
                        Text("Delete From Cache")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                Button(action: {
                    vm.getFromCache()
                }) {
                    Text("Get From Cache")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                if let cachedImage = vm.cachedImage {
                    Image(uiImage: cachedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("21 Savage")
        }
    }
}

struct aboutCache_Previews: PreviewProvider {
    static var previews: some View {
        aboutCache()
    }
}
