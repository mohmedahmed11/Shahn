//
//  CategoryCollectionViewCell.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/14/23.
//

import UIKit
import SwiftyJSON

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setUI(with category: JSON) {
        if let url = URL(string: Glubal.imageBaseurl.path+category["image"].stringValue) {
            image.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
        
        name.text = category["name"].string
    }
}
