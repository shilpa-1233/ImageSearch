//
//  SearchImageModel.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import Foundation

struct SearchImageModel: Codable {
    var total, totalHits: Int?
    var hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable ,BottomSheetTypeProtocol{
    var id: Int?
    var pageURL: String?
    var type, tags: String?
    var previewURL: String?
    var previewWidth, previewHeight: Int?
    var webformatURL: String?
    var webformatWidth, webformatHeight: Int?
    var largeImageURL, fullHDURL, imageURL: String?
    var imageWidth, imageHeight, imageSize, views: Int?
    var downloads, favorites, likes, comments: Int?
    var userID: Int?
    var user: String?
    var userImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, fullHDURL, imageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
    
    func requireSeparator() -> Bool {
        return false
    }
    
    func setLabelText() -> String {
        return tags ?? ""
    }
    
    func idValue() -> Int {
        return id ?? 0
    }
}

