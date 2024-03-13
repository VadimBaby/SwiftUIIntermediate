//
//  aboutFileManager.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 18.05.2023.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    let folderName = "NameOfFolder" // название папки любое
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName, conformingTo: .folder)
                .path() else { return }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("success creating folder")
            } catch let error {
                print("error creating folder: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName, conformingTo: .folder)
                .path() else { return }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder")
        } catch let error {
            print("Error deleting folder: \(error)")
        }
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path(),
            FileManager.default.fileExists(atPath: path) else {
            return "error getting path"
        }
         
        do{
            try FileManager.default.removeItem(atPath: path)
            return "successfully deleted"
        } catch let error {
            return "Error deleting images: \(error)"
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        // сохранение картинки на устройство
        createFolderIfNeeded()
        guard
            // image.pngData() - its for png image
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error getting data"
        }
        
        // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //  let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        // let directory3 = FileManager.default.temporaryDirectory
        
        //  let path = directory?.appendingPathComponent("\(name).jpg")
        
        do {
            try data.write(to: path)
            return "Success saving"
        } catch let error {
            return "error: \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        // получение картинки из file manager устройства
        guard
            let path = getPathForImage(name: name)?.path(),
            FileManager.default.fileExists(atPath: path) else {
            print("error getting path")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        // получения путя до картинки в file manager
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName, conformingTo: .folder)
                .appendingPathComponent("\(name).jpg", conformingTo: .image) else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let nameImage: String = "21"
    let manager = LocalFileManager.instance
    
    @Published var infoMessaging: String = ""
    
    init() {
        getImageFromAssetsFolder()
        // getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: nameImage) // получаем image из папки assets
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: nameImage) // получаем image из file manager устройства
    }
    
    func saveImage() {
        // сохранение изображения на устройство
        guard let image = image else { return }
        infoMessaging = manager.saveImage(image: image, name: nameImage)
    }
    
    func deleteImage() {
        infoMessaging = manager.deleteImage(name: nameImage)
        manager.deleteFolder()
    }
}

struct aboutFileManager: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack{
                    Button(action: {
                        vm.saveImage()
                    }) {
                        Text("Save To FM")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        vm.deleteImage()
                    }) {
                        Text("Delete From FM")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                
                Text(vm.infoMessaging)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct aboutFileManager_Previews: PreviewProvider {
    static var previews: some View {
        aboutFileManager()
    }
}
