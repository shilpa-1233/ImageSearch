//
//  BottomSheetCheckBoxTableViewCell.swift
//  AcquistionApp
//
//  Created by Shilpa Garg on 10/02/20.
//  Copyright © 2020 Scholar Alley. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ImageSearchTableViewCell: UITableViewCell {
    var disposeBag : DisposeBag? = DisposeBag.init()
    @IBOutlet weak var viewinner: UIView!
    @IBOutlet weak var btnRadio: UIButton!
    
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lblHeading: UILabel!
        
    var callBckCheckBoxClicked : (()-> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customize(modelUserData: BottomSheetTypeProtocol) {
        self.lblHeading.text = modelUserData.setLabelText()
        if modelUserData.requireSeparator() == true {
            viewSeparator.backgroundColor = .lightGray
        }
        lblHeading.textColor = .white
    }
    
}
