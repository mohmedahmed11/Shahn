//
//  AboutViewController.swift
//  Fnar
//
//  Created by mohmed  ahmed on 20/11/2021.
//

import UIKit
import SwiftyJSON
import SafariServices

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavJannaFont()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout() {
        AlertHelper.showOkCancel(message: "هل ترغب في تسجيل الخروج") {
            UserDefaults.standard.removeObject(forKey: "userIsIn")
            UserDefaults.standard.removeObject(forKey: "user_phone")
            self.parent?.parent?.navigationController?.popToRootViewController(animated: true)
        }

    }
    
    @IBAction func openTeket() {
        if UserDefaults.standard.value(forKey: "userIsIn") != nil {
            self.performSegue(withIdentifier: "addComment", sender: nil )
        }else {
            AlertHelper.showOkCancel(message: "الرجاء إنشاء حساب اولاً") {
                self.parent?.parent?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

    
    
    @IBAction func opentAgreement() {
        if let url = URL(string: "\(Glubal.termsURL.path)"), UIApplication.shared.canOpenURL(url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @IBAction func contractWhatsapp() {
        guard var phoneNumber = AppManager.shared.about?.whatsapp else { return }
        if phoneNumber.first == "0" {
            phoneNumber.removeFirst()
        }

        let appURL = NSURL(string: "https://api.whatsapp.com/send?text=&phone=966\(phoneNumber)")!
        let webURL = NSURL(string: "https://web.whatsapp.com/send?text=&phone=966\(phoneNumber)")!

        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL as URL)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL as URL)
            }
        }
    }
    
    @IBAction func instegramChat(_ sender: Any) {
        
        guard let Username = AppManager.shared.about?.instagram else { return }
        let appURL = URL(string: "instagram://user?username=\(Username)")!
        let webURL = NSURL(string: "https://instagram.com/\(Username)")!
    
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL as URL)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL as URL)
            }
        }
    }
    
    @IBAction func snapChat(_ sender: Any) {
        
        guard let screenName = AppManager.shared.about?.snapchat else { return }
        let appURL = NSURL(string: "snapchat://app/add/\(screenName)")!
        let webURL = NSURL(string: "https://t.snapchat.com/add/\(screenName)")!
        
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL as URL)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL as URL)
            }
        }
    }
    
    @IBAction func TwitterChat(_ sender: Any) {
        
        guard let screenName = AppManager.shared.about?.twitter else { return }
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
        
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL as URL)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL as URL)
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
