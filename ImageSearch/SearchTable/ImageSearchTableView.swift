//
//  ImageSearchTableView.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 17/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import Foundation
import UIKit

protocol BottomSheetTypeProtocol {
    func requireSeparator() -> Bool
    func setLabelText() -> String
    func idValue() -> Int
}


class BottomSheetCheckBox<T: Codable & BottomSheetTypeProtocol>: UIView,UITableViewDataSource,UITableViewDelegate {
    
    var callback:((Int)->Void)!
    var model : [T]?
    
    var indexSelected : T?
    
    let tableView = UITableView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomSheet(model:[T]) {
        
        self.model = model
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource =  self
        tableView.separatorColor = .black
        tableView.register(UINib.init(nibName: "ImageSearchTableViewCell", bundle: nil), forCellReuseIdentifier:"ImageSearchTableViewCellIdentifier")
        
        self.addSubview(tableView)
        
        let leadingContainerViewAnchor = tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)
        let trailingContainerViewAnchor = tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        let topConstraint = tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150)
        let height = tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height-346)
        height.priority = UILayoutPriority.init(1)
        
        NSLayoutConstraint.activate([leadingContainerViewAnchor, trailingContainerViewAnchor,topConstraint,height])
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissView()
    }
    
    @objc func dismissView() {
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSearchTableViewCellIdentifier") as! ImageSearchTableViewCell
        cell.customize(modelUserData: (model?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callback((indexPath.row))
        dismissView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
}

