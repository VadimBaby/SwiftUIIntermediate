//
//  ImageLoadingViewModel.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 31.05.2023.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    let manager = PhotoModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String){
        urlString = url
        imageKey = key
        
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print ("Getting saved image!")
        } else {
            downloadImage()
            print ("Downloading image now!")
        }
    }
    
    func downloadImage() {
        isLoading = true
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { (_) in
                self.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let image = returnedImage else { return }
                self.image = image
                manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}
