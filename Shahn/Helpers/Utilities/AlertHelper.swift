//
//  AlertHelper.swift
//  Part Time User
//
//  Created by MINI on 29/07/19.
//  Copyright © 2019 MINI. All rights reserved.
//

import UIKit

private struct AlertData {
    
    static var okayCancel:[String] { return  ["تأكيد", "إلغاء"] }
    static var okayNo:[String] { return  ["نعم", "لا"] }
    static var okay:[String] { return  ["موافق"] }
    
}

class AlertHelper: NSObject {
    
    static var applicationName:String {
        return APP_NAME
    }
    
    static let shared = AlertHelper()
    
    func normalAlert(msg: String, view : UIView) {
        let alert = UIAlertController(title: APP_NAME, message: msg, preferredStyle: .alert)
        
        let dismiss = UIAlertAction(title: "موافق", style: .cancel, handler: nil)
        
        alert.addAction(dismiss)
        view.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    
    func ShowTost(view : UIView, message: String) {
        let mesageView = UILabel(frame: CGRect(x: (view.frame.width / 2) - 100, y: (view.frame.height - 100 ), width: 200, height: 30))
        mesageView.backgroundColor = .black
        mesageView.textColor = .white
        mesageView.layer.cornerRadius = 8
        mesageView.isHidden = true
        mesageView.text = message
        mesageView.clipsToBounds = true
        mesageView.font = .systemFont(ofSize: 13)
        mesageView.textAlignment = .center
        
        view.addSubview(mesageView)
        view.bringSubviewToFront(mesageView)
        mesageView.fadeIn(duration: 0.6, delay: 0) { (bool) in
            if bool {
                mesageView.fadeOut(duration: 0.5, delay: 0) { (bool) in
                    if bool {
                        mesageView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    
        static func makeTost(message: String, controller: UIViewController) {
            let toastContainer = UIView(frame: CGRect())
            toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 25;
            toastContainer.clipsToBounds  =  true

            let toastLabel = UILabel(frame: CGRect())
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font.withSize(14.0)
            toastLabel.text = message
            toastLabel.clipsToBounds  =  true
            toastLabel.numberOfLines = 0
            toastContainer.addSubview(toastLabel)
            guard let window = UIApplication.shared.windows.first else {return}
            window.addSubview(toastContainer)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                toastContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 3.0, options: .curveEaseOut, animations: {
                    toastContainer.alpha = 0.0
                }, completion: {_ in
                    toastContainer.removeFromSuperview()
                })
            })
        }
    

    
    
    static func showActionSheet(onController controller:UIViewController? = nil, message:String, actions:[String], completion:((_ index: Int?) -> (Void))?) -> Void {
        
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .actionSheet)
        
        for (index,item) in actions.enumerated() {
            
            let action = UIAlertAction(title: item,
                                       style: .default,
                                       handler: { _ in
                                        completion?(index)
            })
            
            alertController.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "إلغاء",
                                   style: .cancel,
                                   handler:nil)
        alertController.addAction(cancel)
        
        AlertHelper.show(alert: alertController, onController: controller)
    }
    
    
    static func showAlert(onController controller:UIViewController? = nil, title alertTitle:String = AlertHelper.applicationName, message alertMessage:String, actions:[String] = ["موافق"], withCancel:Bool = false, completion:((_ index: Int?) -> (Void))? = nil) -> Void {
        let alertController = UIAlertController(title: alertTitle,
                                                
                                                message: alertMessage,
                                                preferredStyle: .alert)
        
        for (index,item) in actions.enumerated() {
            
            let action = UIAlertAction(title: item,
                                       style: .default,
                                       handler: { _ in
                                        DispatchQueue.main.async { completion?(index) }
            })
            
            alertController.addAction(action)
        }
        
        if withCancel {
            
            let cancel = UIAlertAction(title: ("إلغاء"),
                                       style: .cancel,
                                       handler:nil)
            alertController.addAction(cancel)
        }
        
        AlertHelper.show(alert: alertController, onController: controller)
    }
    
    class func showOkNo(message alertMessage:String,  _ okClosure: @escaping (() -> Void), noClosure: @escaping (() -> Void)) {
        
        showAlert(message: alertMessage, actions: AlertData.okayNo) { (index)  in
            
            if index == 0 {
                
                DispatchQueue.main.async {
                    
                    okClosure()
                }
            } else if index == 1 {
                
                DispatchQueue.main.async {
                    
                    noClosure()
                }
            }
        }
    }
    
    class func showOkCancel(message alertMessage:String,  _ okClosure: @escaping (() -> Void)) {
        
        showAlert(message: alertMessage, actions: AlertData.okayCancel) { (index)  in
            
            if index == 0 {
                
                DispatchQueue.main.async {
                    
                    okClosure()
                }
            }
        }
    }
    
    class func showOk(message alertMessage:String,  _ okClosure: @escaping (() -> Void)) {
        
        showAlert(message: alertMessage, actions: AlertData.okay) { (_)  in
            
            DispatchQueue.main.async {
                
                okClosure()
            }
        }
    }
    
    class func showAlertTextEntry(onController controller:UIViewController? = nil, title alertTitle:String = AlertHelper.applicationName, message alertMessage:String, actions:[String] = ["تأكيد"], placeholderText placeHolder:String = "Enter Text", keyboardType type:UIKeyboardType = .default, withCancel:Bool = false, completion:((_ buttonIndex:Int?, _ textField: UITextField) ->())?) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField:UITextField) in
            textField.placeholder = placeHolder
            textField.keyboardType = type
            
            for (index,item) in actions.enumerated() {
                
                let action = UIAlertAction(title: item,
                                           style: .default,
                                           handler:
                    { _ in
                        completion?(index,textField)
                })
                
                action.isEnabled = false
                alertController.addAction(action)
            }
            
            let cancel = UIAlertAction(title: ("إلغاء"),
                                       style: .cancel,
                                       handler:nil)
            alertController.addAction(cancel)
            
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
                                                   object: textField,
                                                   queue: OperationQueue.main) { (notification) in
                                                    
                                                    alertController.actions.forEach {
                                                        
                                                        if $0.style == UIAlertAction.Style.default {
                                                            
                                                            $0.isEnabled = (textField.text?.isEmpty == false)
                                                        }
                                                    }
            }
        }
        
        AlertHelper.show(alert: alertController, onController: controller)
    }
    
    //PRAGMA MARK: - Private -
    
    private static func show(alert: UIAlertController, onController controller: UIViewController? = nil) -> Void
    {
        let viewC = controller ?? self.topMostController()
        
        DispatchQueue.main.async {
            
            viewC?.present(alert, animated: true, completion: nil)
        }
    }
    
    static private func topMostController() -> UIViewController? {
        
        var topController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController //(UIApplication.shared.delegate as! SceneDelegate).window?.rootViewController ??  //UIApplication.shared.keyWindow?.rootViewController
        
        while ((topController?.presentedViewController) != nil) {
            
            topController = topController?.presentedViewController;
        }
        
        if let controller = AlertHelper.checkForNavigationController(topController) {
            
            return controller
        }
        
        if let childControllers = topController?.children,let controller = self.checkForNavigationController(childControllers.first) {
            
            return controller
        }
        
        return topController
    }
    
    static private func checkForNavigationController(_ controller:UIViewController?) -> UIViewController? {
        
        if let navC = controller as? UINavigationController {
            
            return navC.topViewController
        }
        
        return nil
    }
}


