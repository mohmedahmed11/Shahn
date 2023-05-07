//
//  ImageCollectionViewCell.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/15/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trushBtn: UIButton!
    var remove: (() -> Void)?
    @IBAction func removeAction() {
        remove?()
    }
}
