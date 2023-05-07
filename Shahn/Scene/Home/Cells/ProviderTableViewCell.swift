//
//  ProviderTableViewCell.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/14/23.
//

import UIKit
import SwiftyJSON

class ProviderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var selectionBtn: UIButton!
    @IBOutlet var stars: [UIImageView]!
    
    var checkedCallback: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(with provider: JSON) {
        
        if let url = URL(string: Glubal.imageBaseurl.path+provider["image"].stringValue) {
            providerImage.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
        
        name.text = provider["name"].string
        city.text = provider["city"].string
        type.text = provider["type"].stringValue+" - حمولة "+provider["load_type"].stringValue
        
        for star in stars {
            if star.tag <= provider["rate"].intValue {
                star.image = UIImage(named: "star-fill")
            }else {
                star.image = UIImage(named: "star")
            }
        }
    }
    
    @IBAction func didTapCheckBtn(_ sender: UIButton) {
        if sender.image(for: .normal) == nil {
            sender.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }else {
            sender.setImage(nil, for: .normal)
        }
        self.checkedCallback?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
