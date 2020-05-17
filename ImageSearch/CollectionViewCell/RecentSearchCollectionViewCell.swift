//
//  RecentSearchCollectionViewCell.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

class RecentSearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var OuterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customize(text:String) {
        OuterView.clipsToBounds = true
        OuterView.layer.cornerRadius = 50
        textLabel.text = text
    }

}
