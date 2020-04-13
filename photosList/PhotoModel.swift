//
//  PhotoModel.swift
//  photosList
//
//  Created by User on 2/14/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

struct PhotoModel {
    let name: String
    let photo: UIImage?
    
    static let fakeData: [PhotoModel] = {
         [
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "1")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "2")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "3")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "4")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "5")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "6")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "7")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "8")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "9")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "10")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "11")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "12")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "13")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "14")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "15")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "16")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "17")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "18")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "19")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "20")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "21")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "22")),
            PhotoModel(name: "www.deveble.com", photo: UIImage.init(named: "23"))
        ]
    }()
}
