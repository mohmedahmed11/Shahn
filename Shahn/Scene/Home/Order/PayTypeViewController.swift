//
//  PayTypeViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 5/6/23.
//

import UIKit

protocol PayTypeSelectionSelegate {
    func didSelectPayType(type: Int)
}

class PayTypeViewController: UIViewController {
    
    var delegate:PayTypeSelectionSelegate?
    var payType = 1
    
    @IBOutlet weak var payCashBtn: UIButton!
    @IBOutlet weak var payBankBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payCashAction() {
        payType = 1
        payCashBtn.backgroundColor = UIColor(named: "PrimaryColor")
        payBankBtn.backgroundColor = .systemBackground
    }
    
    @IBAction func payBankAction() {
        payType = 2
        payBankBtn.backgroundColor = UIColor(named: "PrimaryColor")
        payCashBtn.backgroundColor = .systemBackground
    }
    
    @IBAction func confirmSelection () {
        self.dismiss(animated: true)
        self.delegate?.didSelectPayType(type: payType)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
