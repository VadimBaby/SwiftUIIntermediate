//
//  PhotoModel.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 31.05.2023.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
