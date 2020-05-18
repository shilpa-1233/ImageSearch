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
    
    private let previousButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("PREV", for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
          button.setTitleColor(.gray, for: .normal)
          button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
          return button
      }()
      
      @objc private func handlePrev() {
          let nextIndex = max(pageControl.currentPage - 1, 0)
          let indexPath = IndexPath(item: nextIndex, section: 0)
          pageControl.currentPage = nextIndex
          collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      }
      
      private let nextButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("NEXT", for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
          button.setTitleColor(.systemPink, for: .normal)
          button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
          return button
      }()
      
      @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, (imageModel?.hits?.count ?? 1) - 1)
          let indexPath = IndexPath(item: nextIndex, section: 0)
          pageControl.currentPage = nextIndex
          collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      }
      
      private lazy var pageControl: UIPageControl = {
          let pc = UIPageControl()
          pc.currentPage = 0
          pc.numberOfPages = imageModel?.hits?.count ?? 0
          pc.currentPageIndicatorTintColor = .systemPink
          pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
          pc.widthAnchor.constraint(equalToConstant: 80).isActive = true
          return pc
      }()
      
      fileprivate func setupBottomControls() {
          let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, nextButton])
          bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
          bottomControlsStackView.distribution = .fillEqually
          
          view.addSubview(bottomControlsStackView)
          
          NSLayoutConstraint.activate([
              bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
              bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
              bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
              bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
              ])
      }
      
      override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
          
          let x = targetContentOffset.pointee.x
          
          pageControl.currentPage = Int(x / view.frame.width)
          
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib.init(nibName: "ImageSearchFullViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSearchFullViewCollectionViewCellIdentifier")
        setupBottomControls()
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

