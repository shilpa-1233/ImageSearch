//
//  ViewController.swift
//  ImageSearch
//
//  Created by Shilpa Garg on 16/05/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var recentSearchesCollectionView: UICollectionView!
    @IBOutlet weak var recentSearchesCollectionViewHeight: NSLayoutConstraint!
    
    var viewModel : SearchImageViewModel? = SearchImageViewModel()
    let appDelegate : AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var managedContext : NSManagedObjectContext!
    
    var recentSearch : [Image]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.keyboardType = .alphabet
        textField.delegate = self
        recentSearchesCollectionView.delegate = self
        recentSearchesCollectionView.dataSource = self
        recentSearchesCollectionView.register(UINib.init(nibName: "RecentSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentSearchCollectionViewCellIdentifier")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        managedContext = appDelegate?.persistentContainer.viewContext
        fetchFromDatabase()
        self.setNavigationTitle(to: "Wynk")
        self.setBackButton()
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        search(text: textField.text ?? "")
    }
    
    func search(text : String) {
        if text.isEmpty {
            for i in view.subviews {
                if ((i as? ImageSearchTableListView) != nil) {
                    i.removeFromSuperview()
                }
            }
        }else {
            self.view.addImageSearchTableListView(model: [], textToSearch: self.textField.text ?? "", viewModel:self.viewModel, didSelectModel: { index in
                if let index = index {
                    self.saveInDatabase(model: (self.viewModel?.imageData.hits?[index])!)
                    let layout = UICollectionViewFlowLayout.init()
                    layout.scrollDirection = .horizontal
                    let obj = ImageSearchController.init(collectionViewLayout: layout)
                    obj.imageModel = self.viewModel?.imageData
                    obj.indexSelected = index
                    obj.collectionView.scrollToItem(at: IndexPath.init(row: index , section: 0), at: .centeredHorizontally, animated: true)
                    self.navigationController?.pushViewController(obj, animated: false)
                }else {
                    self.NoDataAlert()
                }
            }
            )
        }
    }
    
    func NoDataAlert() {
        let alert = UIAlertController(title: "Alert", message: "No More Data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func saveInDatabase(model : Hit) {
        let imageEntity = NSEntityDescription.entity(forEntityName: "Image", in: managedContext)!
        let image = NSManagedObject(entity: imageEntity, insertInto: managedContext)
        image.setValue(model.tags ?? "", forKeyPath: "url")
        image.setValue(model.id?.description ?? "0", forKey: "id")
        image.setValue(model.tags, forKey: "name")
        let date = Date()
        image.setValue(date, forKey: "date")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchFromDatabase()  {
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        let sort = NSSortDescriptor(key: #keyPath(Image.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchLimit = 10
        do {
            recentSearch = try managedContext.fetch(fetchRequest)
        } catch {
            print("Cannot fetch Expenses")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = ""
        fetchFromDatabase()
        recentSearchesCollectionView.reloadData()
    }
    
}
