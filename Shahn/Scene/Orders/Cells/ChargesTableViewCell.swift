//
//  ChargesTableViewCell.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 5/6/23.
//

import UIKit
import SwiftyJSON

class ChargesTableViewCell: UITableViewCell {
    
    var charge: JSON!
    
    @IBOutlet weak var chargeId: UILabel!
    @IBOutlet weak var serial: UILabel!
    @IBOutlet weak var wight: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var driver: UILabel!
    @IBOutlet weak var follawDriverBtn: UIButton!
    @IBOutlet weak var invoiceBtn: UIButton!
    @IBOutlet weak var driverStack: UIStackView!
    
    var invoiceDetails: (() -> Void)?
    var follawDriver: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(with charge: JSON) {
        self.chargeId.text = "#\(charge["id"].stringValue)"
        self.serial.text = "#\(charge["number"].stringValue)"
        self.date.text = charge["created_at"].string
        self.wight.text = charge["wight"].stringValue+" طن"
        self.driver.text = charge["driver_name"].string
        
        if charge["status"].intValue == 0 {
            status.text = "جديد"
            status.textColor = .systemBlue
            driverStack.isHidden = true
            invoiceBtn.isHidden = true
        }else if charge["status"].intValue == 1 {
            status.text = "جاري الشحن"
            status.textColor = .systemGreen
            follawDriverBtn.isHidden = false
            driverStack.isHidden = false
            invoiceBtn.isHidden = false
        }else if charge["status"].intValue == 2 {
            status.text = "تم التنفيذ"
            status.textColor = .systemRed
            follawDriverBtn.isHidden = true
            driverStack.isHidden = false
            invoiceBtn.isHidden = false
        }
    }
    
    @IBAction func showInvoide() {
        invoiceDetails?()
    }
    
    @IBAction func follawDriverAction() {
        follawDriver?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
