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
    func addImageSearchTableListView(model:[Hit], textToSearch:String,viewModel:SearchImageViewModel!,didSelectModel: @escaping (Int) -> Void,endOfPage: @escaping () -> Void) {
        let objBottomSheet = ImageSearchTableListView.init(frame: self.frame)
        objBottomSheet.addSheet(model: model,textToSearch:textToSearch, viewModel: viewModel)
        self.addSubview(objBottomSheet)
        objBottomSheet.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        objBottomSheet.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        objBottomSheet.topAnchor.constraint(equalTo: self.topAnchor,constant: 160).isActive = true
        objBottomSheet.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive  = true
        objBottomSheet.callback = didSelectModel
        objBottomSheet.bringSubviewToFront(self)
    }
}

extension UIViewController {
    func setNavigationTitle(to str: String) {
        let navTitle = UILabel.init()
        navTitle.attributedText = NSAttributedString.init(string: str, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.kern: 0.2, NSAttributedString.Key.foregroundColor: UIColor.black])
        navTitle.sizeToFit()
        self.navigationItem.titleView = navTitle
    }
    
    func setBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem?.tintColor = .red
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.red
    }
}

