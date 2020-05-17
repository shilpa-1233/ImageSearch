//
//  UIImage+Extension.swift
//  AcquistionApp
//
//  Created by Shilpa Garg on 17/02/20.
//  Copyright © 2020 Scholar Alley. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
extension UIImageView {
    func setImage(for url: String) {
        guard let url = URL.init(string: url) else { return }
        let urlRequest = URLRequest.init(url: url)
        self.af_setImage(withURLRequest: urlRequest)
    }
}
