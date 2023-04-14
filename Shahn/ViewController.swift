//
//  ViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/9/23.
//

import UIKit
import ProgressHUD
import SwiftyJSON

class ViewController: UIViewController {
    
    var timer = Timer()
    var doutCount = 0;
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var reloadBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTimer()
    }
    
    
    func setTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(setLoadingLabel), userInfo: nil, repeats: true)
        timer.fire()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // your code here
            self.loadAppInfo()
        }
        
    }
    
    @objc func setLoadingLabel() {
        self.loadingLabel.textColor = .label
        if doutCount < 3 {
            loadingLabel.text! += "."
            doutCount += 1
        }else {
            loadingLabel.text = "جار التحميل"
            doutCount = 0
        }
    }

    
    
    
    func faildLoading() {
        timer.invalidate()
        self.loadingLabel.text = "فشل التحميل"
        self.reloadBtn.isHidden = false
        self.loadingLabel.textColor = .systemRed
    }
    
    
    @IBAction func reload() {
        self.reloadBtn.isHidden = true
        self.setTimer()
    }
    
    
    func segue() {
        if UserDefaults.standard.value(forKey: "userIsIn") != nil {
//            self.updateToken()
            self.performSegue(withIdentifier: "toHome", sender: nil)
        }else {
            self.performSegue(withIdentifier: "doSign", sender: nil)
        }
    }
    
    func updateToken() {
        NetworkManager.instance.request(with: "\(Glubal.baseurl.path)\(Glubal.users.path)", method: .post, parameters: ["token": accessToken, "id": UserDefaults.standard.string(forKey: "userIsIn")!, "action": "updateToken"],  decodingType: JSON.self, errorModel: ErrorModel.self){ _ in }
    }
    
    
    func loadAppInfo() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        NetworkManager.instance.request(with: Glubal.about.getRequest(parameters: [:])!, decodingType: AboutResponse.self, errorModel: ErrorModel.self) { result in
            ProgressHUD.dismiss()
            switch result {
            case .success(let data):
                AppManager.shared.about = data.about
                self.segue()
                print(data.about.about)
            case .failure(let error):
                self.faildLoading()
                print(error.localizedDescription)
            }
        }
    }

}

