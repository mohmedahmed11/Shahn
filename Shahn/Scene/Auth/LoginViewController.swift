//
//  LoginViewController.swift
//  iParking
//
//  Created by MacBook Pro on 10/04/1442 AH.
//  Copyright © 1442 Pita Studio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phone: UITextField!

    var userPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    

    
    @IBAction func submitAction() {
        
        if phone.text == "" || phone.text == " " {
            let errMessage = "عفوا الرجاء إدخال رقم الهاتف"
            AlertHelper.showAlert(message: errMessage)
            return
        }else{
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale(identifier: "EN")
            if let finalText = numberFormatter.number(from: "\(phone.text!)")
            {
                self.userPhone = "\(finalText)"
                if userPhone.count < 9 || userPhone.subString(from: 0, to: 0) != "5" {
                    let errMessage = "رقم الهاتف غير صالح"
                    AlertHelper.showAlert(message: errMessage)
                    return
                }
                        
            }else {
                let errMessage = "رقم الهاتف غير صالح"
                AlertHelper.showAlert(message: errMessage)
                return
            }
        }
     
        
        sendData()
    }
    
    func sendData() {
 
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.users.path)", method: .post, parameters: [ "phone": self.userPhone, "action": "login"],  decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                if data["operation"].boolValue == true {
                    AppManager.shared.authUser = User(id: data["user"]["id"].stringValue, name: data["user"]["name"].stringValue, phone: data["user"]["phone"].stringValue, contact: data["user"]["contact"].stringValue, image: data["user"]["image"].stringValue)
                    AppManager.shared.authUser?.action = "login"
                    self.sendSmsData()
                }else {
                    AlertHelper.showAlert(message:  "عفواً رقم الهاتف غير موجود")
                }
                
            case .failure(let error):
                AlertHelper.showAlert(message: "عفواً فشل الدخول حاول مرة أخرى")
                print(error.localizedDescription)
            }
        }
       
    }
    
    func sendSmsData() {
        AppManager.shared.authUser?.userCode = Int.random(in: 1111 ... 9999)
        
        guard let user = AppManager.shared.authUser else {
            return
        }
        
        let message = "تطبيق \(APP_NAME) رمز تفعيلك هو : \(user.userCode)"
        let parameters:Parameters = ["message": message.utf8,"phone": "966\(user.phone!)"]
        
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.sms.path)", method: .post, parameters: parameters,  decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success:
                self.performSegue(withIdentifier: "validationCode", sender: self)
            case .failure(let error):
                AlertHelper.showAlert(message: "عفواً فشل الدخول حاول مرة أخرى")
                print(error.localizedDescription)
            }
        }
            
            
    }
    
    @IBAction func valueChanged(_ textField: UITextField) {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        if let finalText = numberFormatter.number(from: "\(textField.text!)")
        {
            textField.text = finalText.stringValue
        }
    }

}
