//
//  VerticalPhotosVC.swift
//  photosList
//
//  Created by User on 2/14/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

class VerticalPhotosVC: UIViewController {
    
    // MARK: - Properties
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let photos: [PhotoModel] = PhotoModel.fakeData
    private var slidingCell: PhotoCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout & UICollectionViewDataSource-
extension VerticalPhotosVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/1.5)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        cell.bgImage = self.photos[indexPath.item].photo
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if slidingCell != nil {
            slidingCell?.bgImageView.heroID = nil
        }
        slidingCell = collectionView.cellForItem(at: indexPath) as? PhotoCell
        slidingCell?.bgImageView.heroID = "Hero"
        let toVC =  PhotoHeroVC()
        toVC.modalPresentationStyle = .fullScreen
        toVC.heroImage = photos[indexPath.item].photo
        present(toVC, animated: true, completion: nil)
    }
}
