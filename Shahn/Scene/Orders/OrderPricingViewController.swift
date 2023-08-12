//
//  OrderPricingViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/13/23.
//

import UIKit
import SwiftyJSON
import Alamofire
import ProgressHUD

class OrderPricingViewController: UIViewController {
    
    var providers: [JSON] = []
    var providersFilltred: [JSON] = []
    var presenter: OrdersPresenter?
    var orderStatus: Int = -1
    var offerStatus: Int = -1
    var order: JSON!
    var providerContact: String = ""
    
    @IBOutlet weak var optionsSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        presenter = OrdersPresenter(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegments()
        providersFilltred = providers
        // Do any additional setup after loading the view.
    }
    
    func setupSegments() {
        let seperatorImage = UIImage(named: "line")
        optionsSegment.setDividerImage(seperatorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "BahijJanna", size: 16) ?? .systemFont(ofSize: 16)]
        optionsSegment.setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    @IBAction func optionChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.providersFilltred = providers
        }else {
            self.providersFilltred = providers.filter({ $0["status"].intValue == sender.selectedSegmentIndex - 1 })
        }
        
        tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "providerDetails" {
            let vc = segue.destination as! ProviderDetailsViewController
            vc.provider = sender as? JSON
        }
        // Pass the selected object to the new view controller.
    }
    
}

extension OrderPricingViewController: PricingOffersStatusDelegate {
    func didStatusChanged(with result: Result<JSON, Error>) {
        if offerStatus == 2 {
            self.sendSMS()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func sendSMS() {
        let message = "تطبيق شاحن \n تم إعتماد عرض التسعير للطلب #\(order["id"].stringValue) - \(order["type"].stringValue)"
        let parameters:Parameters = ["message": message.utf8,"phone": "966\(providerContact)"]
        print(parameters)
        
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.sms.path)", method: .post, parameters: parameters,  decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            self.offerStatus = -1
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension OrderPricingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providersFilltred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProviderOfferTableViewCell
        cell.setUI(with: providersFilltred[indexPath.row])
        if orderStatus != 0 {
            cell.statusBtn.isHidden = true
        }else {
            cell.statusBtn.isHidden = false
        }
        cell.changeStatus = {
            AlertHelper.showActionSheet(message: "تغيير حالة الطلب", actions: ["معتمد", "ملغي"]) { index in
                
                if index == 0 {
                    AlertHelper.showActionSheet(message: "إختر طريقة الرفع", actions: ["الدفع عند الوصول", "دفع إلكتروني"]) { index in
                        self.offerStatus = 2
                        self.providerContact = self.providersFilltred[indexPath.row]["contact"].stringValue
                        self.presenter?.changeOfferStatus(offerId: self.providersFilltred[indexPath.row]["id"].intValue, orderId: self.providersFilltred[indexPath.row]["order_id"].intValue, status: 2, paymentType: (index ?? 0) + 1)
                    }
                }else {
                    self.presenter?.changeOfferStatus(offerId: self.providersFilltred[indexPath.row]["id"].intValue, orderId: self.providersFilltred[indexPath.row]["order_id"].intValue, status: 4, paymentType: 0)
                }
            }
        }
        cell.providerDetails = {
            self.performSegue(withIdentifier: "providerDetails", sender: self.providersFilltred[indexPath.row]["provider"])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
