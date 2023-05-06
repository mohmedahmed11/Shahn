//
//  AddCommentViewController.swift
//  iParking
//
//  Created by MacBook Pro on 15/04/1442 AH.
//  Copyright © 1442 Pita Studio. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class AddCommentViewController: UIViewController ,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var daibetes: UITextField!
    @IBOutlet weak var note: UITextView!
    
    var errVal = 0;
    
    @IBOutlet weak var actionBtn: UIButton!
    
    var pickerView = UIPickerView()
    var currentTextFied = UITextField()
    
    var case_id = ""
    var userPhone = ""
    var json:[JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.note.placeholder = "الوصف"
        loadData()
        if UserDefaults.standard.value(forKey: "userIsIn") != nil {
            self.phone.text = "\(UserDefaults.standard.value(forKey: "user_phone")!)"
        }
    }
    
    func loadData() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: Glubal.inquiries.getRequest(parameters: [:])!, decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                self.json = data["data"].arrayValue
            case .failure(let error):
//                self.faildLoading()
                print(error.localizedDescription)
            }
        }

    }
    
    @IBAction func picAction() {
        currentTextFied = daibetes
        if json.isEmpty {
            self.loadData()
        }else {
            daibetes.inputView = pickerView
            daibetes.becomeFirstResponder()
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self

        currentTextFied = textField
        if currentTextFied == daibetes {
            if json.isEmpty {
                self.loadData()
            }else {
                daibetes.inputView = pickerView
            }
        }
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTextFied == daibetes {
            return json.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentTextFied == daibetes {
            
            return json[row]["name"].string
        } else {
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if currentTextFied == daibetes {
        
            self.daibetes.text = json[row]["name"].string
            self.case_id = json[row]["id"].stringValue
            
        }
        self.view.layoutIfNeeded()
        self.view.endEditing(true)
    }
    
    @IBAction func submit() {
        
        if daibetes.text == "" || daibetes.text == " " {
            let errMessage = "عفوا يجب إختيار موضوع التواصل أولا"
            AlertHelper.showAlert(message:  errMessage)
            return
        }
       
        if note.text == "" || note.text == " " {
            let errMessage = "عفوا الوصف مطلوب"
            AlertHelper.showAlert(message:  errMessage)
            return
        }
        
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
        
        let user_id = "\(UserDefaults.standard.value(forKey: "userIsIn")!)"
        let parameters:Parameters = ["id": user_id,"customer_mobile": userPhone, "query_text": self.daibetes.text!.utf8, "inquiry_id":  self.case_id,"note": note.text!.utf8]
        
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.createInquiry.path)", method: .post, parameters: parameters, decodingType: JSON.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                if data["operation"].boolValue == true {
                    AlertHelper.showAlert(message:  "تم الإرسال")
                    self.navigationController?.popViewController(animated: true)
                }else {
                    AlertHelper.showAlert(message:  "عفواً حاول مرة أخرى")
                }
                
            case .failure(let error):
                AlertHelper.showAlert(message: "عفواً حاول مرة أخرى")
                print(error.localizedDescription)
            }
        }
        
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
