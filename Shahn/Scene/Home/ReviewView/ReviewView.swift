//
//  CarReviewView.swift
//  Kaar
//
//  Created by Mohamed Ahmed on 3/10/23.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ReviewView: UIView {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet var rateStars: [UIImageView]!
    @IBOutlet weak var reviewLbl: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = Bundle.main.loadNibNamed("ReviewView", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.frame = bounds
        addSubview(view!)
    }
    
    func setData(review: JSON) {
        userName.text = review["name"].string
        reviewLbl.text = review["review"].string
        if let url = URL(string: Glubal.imageBaseurl.path+review["image"].stringValue) {
            userImage.kf.setImage(with: url, placeholder: UIImage(named: "ownerProfile"))
        }
        
        for star in rateStars {
            if star.tag <= review["rate"].intValue {
                star.image = UIImage(named: "star-fill")
            }else {
                star.image = UIImage(named: "star")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
