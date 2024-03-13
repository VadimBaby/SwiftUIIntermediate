//
//  PhotoModelFileManager.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 31.05.2023.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Folder created")
            } catch let error {
                print("Error create folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName, conformingTo: .folder)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil}
        return folder.appendingPathComponent(key + ".png", conformingTo: .image)
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path()) else { return nil }
        
        return UIImage(contentsOfFile: url.path())
    }
}
