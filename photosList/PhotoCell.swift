//
//  PhotoCell.swift
//  photosList
//
//  Created by User on 2/14/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var bgImage: UIImage? {
        didSet {
            guard let bgImage = bgImage else { return }
            bgImageView.image = bgImage
        }
    }
    
    let bgImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgImageView)
        bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
