//
//  ValidationCodeViewController.swift
//  iParking
//
//  Created by MacBook Pro on 10/04/1442 AH.
//  Copyright © 1442 Pita Studio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class ValidationCodeViewController: UIViewController {

    @IBOutlet var Code: [UITextField]!
    @IBOutlet weak var skipValidationNumberLabel: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    
    @IBOutlet weak var resendBtn: UIButton!
    
    var userCode = ""

    var skipValidationNumber: Int = 100

    var timer : Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.phone.text = AppManager.shared.authUser!.phone
       
        // Do any additional setup after loading the view.
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    

    @objc func fire()
    {
        if skipValidationNumber > 0 {
            skipValidationNumber = skipValidationNumber - 1
            self.skipValidationNumberLabel.text = "\(skipValidationNumber)"
        }else {
            timer.invalidate()
            self.skipValidationNumberLabel.text = ""
            self.skipValidationNumberLabel.isHidden = true
            self.resendBtn.isHidden = false
        }
    }
    
    @IBAction func submitData() {
        if Code[3].text == "" || Code[3].text == " " {
            let errMessage = "عفوا رمز التحقق مطلوب"
            AlertHelper.showAlert(message: errMessage)
            return
        }
        guard let sms = AppManager.shared.sms else {
            return
        }
     
        if self.userCode == sms.admin || self.userCode == "\(AppManager.shared.authUser!.userCode)" {
            if AppManager.shared.authUser?.action == "register" {
                sendData()
            } else if AppManager.shared.authUser?.action == "login" {
                saveUser()
            }
            
        }else {
            self.Code[0].text = nil
            self.Code[1].text = nil
            self.Code[2].text = nil
            self.Code[3].text = nil
            self.view.endEditing(true)
            let errMessage = "رمز التحقق غير صحيح"
            AlertHelper.showAlert(message: errMessage)
            return
        }
    }
    
    func saveUser() {
        UserDefaults.standard.set(AppManager.shared.authUser!.id, forKey: "userIsIn")
        UserDefaults.standard.set(AppManager.shared.authUser!.phone, forKey: "user_phone")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func sendData() {
        
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        let data = MultipartFormData()
        data.append(AppManager.shared.authUser!.name!.data(using: .utf8)!, withName: "name")
        data.append(AppManager.shared.authUser!.phone!.data(using: .utf8)!, withName: "phone")
        data.append(AppManager.shared.authUser!.contact!.data(using: .utf8)!, withName: "contact")
        data.append("register".data(using: .utf8)!, withName: "action")
        
        NetworkManager.instance.requestWithFiles(with: data, to: "\(Glubal.baseurl.path)\(Glubal.users.path)", headers: Glubal.baseurl.mutipartHeaders, decodingType: JSON.self, errorModel: ErrorModel.self) { [weak self] result in
            print(result)
            ProgressHUD.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
                if data["operation"].boolValue == true {
                    AppManager.shared.authUser?.id = data["user"]["id"].stringValue
                    self.saveUser()
                }else {
                    AlertHelper.showAlert(message:  "عفواً فشل التسجيل حاول مرة أخرى")
                }
                
            case .failure(let error):
                AlertHelper.showAlert(message: "عفواً فشل التسجيل حاول مرة أخرى")
                print(error.localizedDescription)
            }
        }
    }
    
   
    
    @IBAction func reSendCode() {
        
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
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension ValidationCodeViewController: UITextFieldDelegate {
    
    @IBAction func valueChange(_ textField: UITextField) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        if let finalText = numberFormatter.number(from: "\(textField.text!)")
        {
            textField.text = "\(finalText)"
        }
        
        if textField.tag == 3 {
            self.userCode = "\(Code[0].text!)\(Code[1].text!)\(Code[2].text!)\(Code[3].text!)"
            self.submitData()
        }else {
            Code[textField.tag + 1].becomeFirstResponder()
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(Code.count)
        for index in 0..<Code.count {
            if Code[index].text!.count == 0 {
                
                DispatchQueue.main.async {
                    self.Code[index].becomeFirstResponder()
                    
                }
                break
            }
        }
    }
 
}
