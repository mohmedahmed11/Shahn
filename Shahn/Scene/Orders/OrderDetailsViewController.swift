//
//  OrderDetailsViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/14/23.
//

import UIKit
import SwiftyJSON

class OrderDetailsViewController: UIViewController {
    
    var order: JSON!
    var images: [JSON] = []
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var wight: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var picLocation: UILabel!
    @IBOutlet weak var dropLocation: UILabel!
    @IBOutlet weak var chargeDate: UILabel!
    @IBOutlet weak var reciverName: UILabel!
    @IBOutlet weak var reciverPhone: UILabel!
    @IBOutlet weak var providerStack: UIStackView!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var providerPhone: UILabel!
    @IBOutlet weak var providerOfferPrice: UILabel!
    @IBOutlet weak var providerOfferDaies: UILabel!
    @IBOutlet weak var chargesBtn: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        // Do any additional setup after loading the view.
    }
    
    func setData() {
        type.text = order["type"].string
        wight.text = !order["wight"].string!.isEmpty ? "الوزن: \(order["wight"].stringValue)" : "الردود: \(order["circles"].stringValue) ردود"
        details.text = order["details"].string
        chargeDate.text = "تاريخ الشحن: \(order["charge_date"].stringValue)"
        picLocation.text = "الشحن: \(order["pickup_lat"].stringValue) : \(order["pickup_lon"].stringValue)"
        dropLocation.text = "التفريغ: \(order["dropoff_lat"].stringValue) : \(order["dropoff_lon"].stringValue)"
        reciverName.text = order["receiver_name"].string
        reciverPhone.text = order["receiver_phone"].string
        images = order["images"].arrayValue
        imagesCollectionView.reloadData()
        if order["status"].intValue != 0 && order["status"].intValue != 3 {
            if let provider = order["providers"].arrayValue.first(where: { $0["status"].intValue == 2 }) {
                providerName.text = provider["name"].string
                providerPhone.text = provider["contact"].string
                providerOfferPrice.text = "\(provider["price"].stringValue) ريال"
                providerOfferDaies.text = "\(provider["duration"].stringValue) يوم"
            }
        }else {
            self.providerStack.isHidden = true
            self.chargesBtn.isHidden = true
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "pricing" {
            let vc = segue.destination as! OrderPricingViewController
            vc.providers = order["providers"].arrayValue
        }else if segue.identifier == "charges" {
            let vc = segue.destination as! OrderLoadsViewController
            vc.charges = order["charges"].arrayValue
        }
        // Pass the selected object to the new view controller.
    }

}

extension OrderDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        if let url = URL(string: Glubal.imageBaseurl.path+images[indexPath.row]["image"].stringValue) {
            cell.imageView.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height
        return .init(width: size, height: size)
    }
}
