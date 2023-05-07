//
//  OrderLoadsViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/14/23.
//

import UIKit
import SwiftyJSON
import SafariServices

class OrderLoadsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var charges: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension OrderLoadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChargesTableViewCell
        cell.setUI(with: charges[indexPath.row])
        cell.chargeId.text = "#\(indexPath.row + 1)"
        cell.invoiceDetails = {
            self.openFile(with: self.charges[indexPath.row]["invoice"].stringValue)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func openFile(with url: String) {
        if let url = URL(string: "\(Glubal.filesBaseurl.path)\(url)"){
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
}
