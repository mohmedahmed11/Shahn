//
//  Extes.swift
//  sudia_zabayih
//
//  Created by iMac on 2019/01/29.
//  Copyright © 2019 awad. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}



@IBDesignable
class DesignableImageView: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}



@IBDesignable
class DesignableLabel: UILabel {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}


@IBDesignable
extension UITextField {
    


    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}


//
//extension UIView {
//
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//        }
//    }
//
//    @IBInspectable
//    var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    @IBInspectable
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
//
//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
//}


//
//extension UITextField {
//    func setIcon(_ image: UIImage) {
//        let iconView = UIImageView(frame:
//            CGRect(x: 10, y: 5, width: 20, height: 20))
//        iconView.image = image
//        let iconContainerView: UIView = UIView(frame:
//            CGRect(x: 20, y: 0, width: 40, height: 30))
//        iconContainerView.addSubview(iconView)
//        //        leftView?.rightAnchor.constraint(equalTo: rightView!.rightAnchor, constant: 10)
//        //        leftView?.la
//        leftView = iconContainerView
//        leftViewMode = .always
//    }
//
//    func setButtomBorder(backgroundColor:UIColor,borderColor:UIColor){
//        self.layer.backgroundColor = backgroundColor.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
//        self.layer.shadowColor = borderColor.cgColor
//    }
//}


extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
                placeholderLabel.textAlignment = .center
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top
            let labelWidth = self.frame.width - 20
            let labelHeight = placeholderLabel.frame.height
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            placeholderLabel.textAlignment = .right
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}



extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveLinear, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
}



@IBDesignable
final class SideBorders: UIView {
    @IBInspectable var topColor: UIColor = UIColor.clear
    @IBInspectable var topWidth: CGFloat = 0
    
    @IBInspectable var rightColor: UIColor = UIColor.clear
    @IBInspectable var rightWidth: CGFloat = 0
    
    @IBInspectable var bottomColor: UIColor = UIColor.clear
    @IBInspectable var bottomWidth: CGFloat = 0
    
    @IBInspectable var leftColor: UIColor = UIColor.clear
    @IBInspectable var leftWidth: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        let topBorder = CALayer()
        topBorder.backgroundColor = topColor.cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: topWidth)
        self.layer.addSublayer(topBorder)
        
        let rightBorder = CALayer()
        rightBorder.backgroundColor = rightColor.cgColor
        rightBorder.frame = CGRect(x: self.frame.size.width - rightWidth, y: 0, width: rightWidth, height: self.frame.size.height)
        self.layer.addSublayer(rightBorder)
        
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = bottomColor.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - bottomWidth, width: self.frame.size.width, height: bottomWidth)
        self.layer.addSublayer(bottomBorder)
        
        let leftBorder = CALayer()
        leftBorder.backgroundColor = leftColor.cgColor
        leftBorder.frame = CGRect(x: 0, y: self.frame.size.height - leftWidth, width: self.frame.size.width, height: leftWidth)
        self.layer.addSublayer(leftBorder)
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    func size(constraintedWidth width: CGFloat = 0, height: CGFloat = 0,font: UIFont ) -> CGSize {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: (width == 0) ?  .greatestFiniteMagnitude : width, height: (height == 0) ?  .greatestFiniteMagnitude : height))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.size
    }
    
    func size(constraintedWidth width: CGFloat = 0, height: CGFloat = 0,fontName: String, fontSize: CGFloat) -> CGSize {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: (width == 0) ?  .greatestFiniteMagnitude : width, height: (height == 0) ?  .greatestFiniteMagnitude : height))
        label.numberOfLines = 0
        label.text = self
        label.font = UIFont(name: fontName, size: fontSize)
        label.sizeToFit()
        return label.frame.size
    }
}


let MAIN_COLOR = #colorLiteral(red: 0.1215686275, green: 0.3764705882, blue: 0.5607843137, alpha: 1) //UIColor(red: 165/255, green: 31/255, blue: 102/255, alpha: 1)
let LIGHT_GREY = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)


// ------------------------------------------------
// MARK: - UTILITY EXTENSIONS
// ------------------------------------------------
var hud = UIView()
var loadingCircle = UIImageView()
var toast = UILabel()

extension UIViewController {
    
    // ------------------------------------------------
    // MARK: - SHOW TOAST MESSAGE
    // ------------------------------------------------
    func showToast(_ message:String) {
        toast = UILabel()
        toast.translatesAutoresizingMaskIntoConstraints = false
//        toast.frame.origin.y = view.frame.size.height - 100
        toast.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        toast.center = view.center
//        toast.bottomAnchor =
//        toast.font = UIFont(name: "Somer", size: 18)
        toast.textColor = UIColor.white
        toast.textAlignment = .center
        toast.adjustsFontSizeToFitWidth = true
        toast.numberOfLines = 0
        toast.text = message
        toast.layer.cornerRadius = 14
        toast.clipsToBounds = true
        toast.backgroundColor = MAIN_COLOR
        view.addSubview(toast)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(hideToast), userInfo: nil, repeats: false)
    }
    @objc func hideToast() {
        toast.removeFromSuperview()
    }
    
    // ------------------------------------------------
    // MARK: - SHOW/HIDE LOADING HUD
    // ------------------------------------------------
    func showHUD() {
        hud.frame = CGRect(x:0, y:0,
                           width:view.frame.size.width,
                           height: view.frame.size.height)
        hud.backgroundColor = UIColor.white
        hud.alpha = 0.7
        view.addSubview(hud)
        
        loadingCircle.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loadingCircle.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        loadingCircle.image = UIImage(named: "loading_circle")
        loadingCircle.contentMode = .scaleAspectFill
        loadingCircle.clipsToBounds = true
        animateLoadingCircle(imageView: loadingCircle, time: 0.8)
        view.addSubview(loadingCircle)
    }
    func animateLoadingCircle(imageView: UIImageView, time: Double) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = time
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: nil)
    }
    func hideHUD() {
        hud.removeFromSuperview()
        loadingCircle.removeFromSuperview()
}

}
class Toasts {
    static func show(message: String, controller: UIViewController) {
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
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, c3])

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
}


extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}


extension String {
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}




extension UISegmentedControl
{
    func defaultConfiguration(font: UIFont = UIFont.systemFont(ofSize: 12), color: UIColor = UIColor.white)
    {
        let defaultAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }

    func selectedConfiguration(font: UIFont = UIFont.boldSystemFont(ofSize: 12), color: UIColor = UIColor.red)
    {
        let selectedAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}



extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

extension Date {

    func toString(withFormat format: String = "d MMMM") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ar_DZ")
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
//        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}



extension UICollectionView {
    var widestCellWidth: CGFloat {
        let insets = contentInset.left + contentInset.right
        return bounds.width - insets
    }
}




extension UIViewController
{
    func setLeftAlignedNavigationItemTitle(text: String,
                                           color: UIColor,
                                           margin left: CGFloat)
    {
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.navigationItem.titleView = titleLabel

        guard let containerView = self.navigationItem.titleView?.superview else { return }

        // NOTE: This always seems to be 0. Huh??
        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: (leftBarItemWidth ?? 0) + left),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
}

extension UIViewController {
    func customNavJannaFont() {
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [
            .font: UIFont(name: "BahijJanna-Bold", size: 18)!
        ]
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [
            .font: UIFont(name: "BahijJanna-Bold", size: 18)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "BahijJanna-Bold", size: 18)!
        ]
    }

}



extension UIViewController {
  func toastMessage(_ message: String){
      guard let window = UIApplication.shared.windows.first else {return}
    let messageLbl = UILabel()
    messageLbl.text = message
    messageLbl.textAlignment = .center
    messageLbl.font = UIFont.systemFont(ofSize: 12)
    messageLbl.textColor = .white
    messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)

    let textSize:CGSize = messageLbl.intrinsicContentSize
    let labelWidth = min(textSize.width, window.frame.width - 40)

    messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
    messageLbl.center.x = window.center.x
    messageLbl.layer.cornerRadius = messageLbl.frame.height/2
    messageLbl.layer.masksToBounds = true
    window.addSubview(messageLbl)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

    UIView.animate(withDuration: 1, animations: {
        messageLbl.alpha = 0
    }) { (_) in
        messageLbl.removeFromSuperview()
    }
    }
}}


extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
