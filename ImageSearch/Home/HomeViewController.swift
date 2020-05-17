//
//  ViewController.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 16/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var recentSearchesCollectionView: UICollectionView!
    @IBOutlet weak var recentSearchesCollectionViewHeight: NSLayoutConstraint!
    
    var viewModel : SearchImageViewModel? = SearchImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.keyboardType = .alphabet
        textField.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(UIResponder.keyboardDidShowNotification)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        recentSearchesCollectionViewHeight.constant = 0
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel?.search(query: textField.text?.appending(string) ?? "") { response,errror in
            self.view.addBottomSheetCheckbox(model: response?.hits ?? [], didSelectModel: { index in
                let layout = UICollectionViewFlowLayout.init()
                layout.scrollDirection = .horizontal
                let obj = ImageSearchController.init(collectionViewLayout: layout)
                obj.imageModel = response
                obj.indexSelected = index
                self.navigationController?.pushViewController(obj, animated: false)
            })
        }
        
        return true
    }
    
}

