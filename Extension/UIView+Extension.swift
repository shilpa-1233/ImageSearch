//
//  UIView+Extension.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBottomSheetCheckbox<T:Codable & BottomSheetTypeProtocol>(model:[T], didSelectModel: @escaping (Int) -> Void) {
        let objBottomSheet = BottomSheetCheckBox<T>.init(frame: self.frame)
        objBottomSheet.addBottomSheet(model: model)
        self.addSubview(objBottomSheet)
        objBottomSheet.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        objBottomSheet.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        objBottomSheet.topAnchor.constraint(equalTo: self.topAnchor,constant: 160).isActive = true
        objBottomSheet.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive  = true
        objBottomSheet.callback = didSelectModel
        objBottomSheet.bringSubviewToFront(self)
    }
}

