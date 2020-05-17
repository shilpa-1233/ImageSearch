//
//  SearchImageViewModel.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import SVProgressHUD
import Alamofire

class SearchImageViewModel {
//      var dataSource = BehaviorRelay<[TaskListSectionModel]>.init(value: [])
      var disposeBag: DisposeBag = DisposeBag.init()
    
    let AF = SessionManager.default
    
    var imageData : SearchImageModel?

    func search(query: String, completion result: @escaping (SearchImageModel?, Error?) -> Void) {
        let parameters: [String:Any] = [
            "key": NetworkConstants.pixabayApiKey,
            "q": query,
            "orientation": "vertical",
            "safesearch": true,
            "per_page": 4,
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
