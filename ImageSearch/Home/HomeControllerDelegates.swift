//
//  HomeControllerDelegates.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import Foundation
import UIKit


extension HomeViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        recentSearchesCollectionViewHeight.constant = 120
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        recentSearchesCollectionViewHeight.constant = 0
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentSearch?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentSearchCollectionViewCellIdentifier", for: indexPath) as? RecentSearchCollectionViewCell
        cell?.OuterView.clipsToBounds = true
        cell?.OuterView.layer.masksToBounds = true
        cell?.OuterView.layer.cornerRadius = 20
        cell?.customize(text: recentSearch?[indexPath.row].name ?? "")
        return cell!
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.searchById(id: recentSearch?[indexPath.row].id ?? "0", completion: { response , error in
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = .horizontal
            let obj = ImageSearchController.init(collectionViewLayout: layout)
            obj.imageModel = response
            self.navigationController?.pushViewController(obj, animated: false)
        })
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

