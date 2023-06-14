//
//  ProviderOfferTableViewCell.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 5/6/23.
//

import UIKit
import SwiftyJSON

class ProviderOfferTableViewCell: UITableViewCell {

    var provider: JSON!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var circles: UILabel!
    @IBOutlet weak var daies: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var statusBtn: UIButton!
    
    var changeStatus: (() -> Void)?
    var providerDetails: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(with provider: JSON) {
        name.text = provider["name"].string
        price.text = "\(provider["price"].stringValue) ريال"
        circles.text = "\(provider["circles"].stringValue) شحنة"
        daies.text = "\(provider["duration"].stringValue) يوم"
        date.text = provider["created_at"].string
        
        print(provider)
        
        if provider["status"].intValue == 0 {
            status.text = "جديد"
            status.textColor = .systemBlue
        }else if provider["status"].intValue == 1 {
            status.text = "معتمد"
            status.textColor = .systemOrange
        }else if provider["status"].intValue == 2 {
            status.text = "تم التنفيذ"
            status.textColor = .systemGreen
        }else {
            status.text = "ملغي"
            status.textColor = .systemRed
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeStatusAction() {
        changeStatus?()
    }
    
    @IBAction func showProviderDetails() {
        providerDetails?()
    }

}
