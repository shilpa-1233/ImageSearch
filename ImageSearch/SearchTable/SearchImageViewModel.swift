//
//  SearchImageViewModel.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import Foundation
import Alamofire

class SearchImageViewModel {
    
    let AF = SessionManager.default
    
    var imageData = SearchImageModel.init()

    func search(query: String, completion result: @escaping (SearchImageModel?, Error?) -> Void) {
        let parameters: [String:Any] = [
            "key": NetworkConstants.pixabayApiKey,
            "q": query,
            "orientation": "vertical",
            "safesearch": true,
            "per_page": 10,
            "image_type": "photo"
        ]
        
        AF.request(NetworkConstants.baseUrl, method: .get, parameters: parameters).response(completionHandler: { [weak self](response) in
            guard let strongSelf = self else {return}
            if response.response?.statusCode == 200 {
                let imageDataResponse = try! JSONDecoder.init().decode(SearchImageModel.self, from: response.data!)
                if let _ = strongSelf.imageData.hits {
                    strongSelf.imageData.hits?.append(contentsOf: imageDataResponse.hits ?? [])
                }else {
                    strongSelf.imageData = imageDataResponse
                }
                result(self?.imageData, response.error)
            }else {
                result(nil,response.error)
            }
        })
        }
    
    func searchById(id: String, completion result: @escaping (SearchImageModel?, Error?) -> Void) {
    let parameters: [String:Any] = [
        "key": NetworkConstants.pixabayApiKey,
        "id": id,
        "orientation": "vertical",
        "safesearch": true,
        "per_page": 10,
        "image_type": "photo"
    ]
    
    AF.request(NetworkConstants.baseUrl, method: .get, parameters: parameters).response(completionHandler: { [weak self](response) in
        if response.response?.statusCode == 200 {
            self?.imageData = try! JSONDecoder.init().decode(SearchImageModel.self, from: response.data!)
            result(self?.imageData, response.error)
        }else {
            result(nil,response.error)
        }
    })
    }
    }
