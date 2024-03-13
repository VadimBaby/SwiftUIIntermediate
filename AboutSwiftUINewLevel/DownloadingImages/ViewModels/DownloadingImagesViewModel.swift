//
//  DownloadingImagesViewModel.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 31.05.2023.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubcribers()
    }
    
    func addSubcribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
    
}
