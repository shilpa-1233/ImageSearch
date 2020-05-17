//
//  ViewController.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 16/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var recentSearchesCollectionView: UICollectionView!
    @IBOutlet weak var recentSearchesCollectionViewHeight: NSLayoutConstraint!
    
    var viewModel : SearchImageViewModel? = SearchImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.keyboardType = .alphabet
        textField.delegate = self
        recentSearchesCollectionView.delegate = self
        recentSearchesCollectionView.dataSource = self
        recentSearchesCollectionView.register(UINib.init(nibName: "RecentSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentSearchCollectionViewCellIdentifier")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        if textField.text?.isEmpty ?? false {
            for i in view.subviews {
                if ((i as? BottomSheetCheckBox<Hit>) != nil) {
                    i.removeFromSuperview()
                }
            }
        }else {
            viewModel?.search(query: textField.text ?? "") { response,errror in
                self.view.addBottomSheetCheckbox(model: response?.hits ?? [], didSelectModel: { index in
                    let layout = UICollectionViewFlowLayout.init()
                    layout.scrollDirection = .horizontal
                    let obj = ImageSearchController.init(collectionViewLayout: layout)
                    obj.imageModel = response
                    obj.indexSelected = index
                    self.navigationController?.pushViewController(obj, animated: false)
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = ""
    }
    
}
