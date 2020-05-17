//
//  ImageSearchController.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageSearchFullViewCollectionViewCellIdentifier"

class ImageSearchController: UICollectionViewController {

    
    var imageModel: SearchImageModel?
    var indexSelected: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib.init(nibName: "ImageSearchFullViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSearchFullViewCollectionViewCellIdentifier")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.scrollToItem(at: IndexPath.init(row: indexSelected ?? 0, section: 0), at: .centeredVertically, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel?.hits?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageSearchFullViewCollectionViewCell
        cell?.customize(imageUrl:imageModel?.hits?[indexPath.row].largeImageURL ?? "https://pixabay.com/get/35bbf209e13e39d2_640.jpg" )
        return cell!
    }
}

extension ImageSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

