//
//  UserAccountViewController.swift
//  iParking
//
//  Created by MacBook Pro on 15/04/1442 AH.
//  Copyright © 1442 Pita Studio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

protocol UserAccountViewControllerDelegate {
    func didUpdateProfile()
}

class UserAccountViewController: UIViewController {
    
    var userJson: JSON = []
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var contact: UITextField!
    
    var userContact = ""
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavJannaFont()
        hideKeyboardWhenTappedAround()
        loadUserInfo()
        
        // Do any additional setup after loading the view.
    }
    
    func loadUserInfo() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.getUser.path)", parameters: ["id": UserDefaults.standard.value(forKey: "userIsIn") ?? "-1"], decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                if data["operation"].boolValue == true {
                    AppManager.shared.authUser = User(id: data["user"]["id"].stringValue, name: data["user"]["name"].stringValue, phone: data["user"]["phone"].stringValue, contact: data["user"]["contact"].stringValue)
                    self.setData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func setData() {
        
        if let user = AppManager.shared.authUser {
            self.name.text = user.name
            self.phone.text = user.phone
            self.contact.text = user.contact
        }
        
    }
    
    @IBAction func updateAction() {
        if name.text == "" || name.text == " " {
            return
        }
       
        sendUpdate()
    }
    
    func sendUpdate() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.users.path)", method: .post, parameters: ["id": AppManager.shared.authUser!.id, "name": self.name.text!, "contact": contact.text!, "action": "update"], decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                if data["operation"].boolValue == true {
                    AlertHelper.showAlert(message: "تم تعديل بيانات الحساب")
                }else {
                    AlertHelper.showAlert(message:  "عفواً فشل التعديل حاول مرة أخرى")
                }
                
            case .failure(let error):
                AlertHelper.showAlert(message: "عفواً فشل التعديل حاول مرة أخرى")
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func deleteAccount() {
        AlertHelper.showOkCancel(message: "هل ترغب في حذف الحساب") {
            self.sendDeleteAccount()
        }
    }
    
    func sendDeleteAccount() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.users.path)", method: .post, parameters: ["id": AppManager.shared.authUser!.id, "action": "delete"], decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                if data["operation"].boolValue == true {
                    AlertHelper.showOk(message: "تم حذف الحساب") {
                        self.logout()
                    }
                }else {
                    AlertHelper.showAlert(message:  "عفواً فشل الحذف حاول مرة أخرى")
                }
                
            case .failure(let error):
                AlertHelper.showAlert(message: "عفواً فشل الحذف حاول مرة أخرى")
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "userIsIn")
        UserDefaults.standard.removeObject(forKey: "user_phone")
        self.parent?.parent?.navigationController?.popToRootViewController(animated: true)
    
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
