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
        if charges.isEmpty {
            addNoData()
        }
        // Do any additional setup after loading the view.
    }
    
    func addNoData() {
        let error = noDataFoundNip()
        error.frame.size.height = 200
        error.content.text = "لاتوجد شحنات"
        self.tableView.backgroundView = error
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openLocation" {
            let vc = segue.destination as! ShowAddressViewController
            vc.locationJSON = sender as? JSON
        }
    }
    

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
        cell.follawDriver = {
            self.performSegue(withIdentifier: "openLocation", sender: JSON(["lat": self.charges[indexPath.row]["lat"].doubleValue ,"lon": self.charges[indexPath.row]["lon"].doubleValue]))
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
