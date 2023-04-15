//
//  CreateOrderViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/12/23.
//

import UIKit
import YPImagePicker
import Alamofire
import SwiftyJSON
import CoreLocation

class CreateOrderViewController: UIViewController {
    
    var config = YPImagePickerConfiguration()
    let picker = YPImagePicker()
    
    var images:[UIImage] = []
    
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var wight: UITextField!
    @IBOutlet weak var circles: UITextField!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var picUp: UILabel!
    @IBOutlet weak var dropOff: UILabel!
    @IBOutlet weak var chargeDate: UITextField!
    @IBOutlet weak var reciverName: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var wightBtn: UIButton!
    @IBOutlet weak var circlesBtn: UIButton!
    
    let datePicker: UIDatePicker = UIDatePicker()
    var selectedDateIs: String?
    
    var picUpLacation: CLLocationCoordinate2D!
    var dropOffLacation: CLLocationCoordinate2D!
    
    enum ContentType {
        case wight
        case circles
    }
    
    var contentType: ContentType = .wight
    
    enum PicLocationFor {
        case picUp
        case dropOff
    }
    
    var picLocationFor: PicLocationFor = .picUp

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        details.placeholder = "وصف البضاعة"
        setupContentType()
        setupDatePicker()
        configerImagePicer()
        // Do any additional setup after loading the view.
    }
    
    func setupDatePicker() {
//        self.totalAmount.text = "\(totalAmountVal + deleverTaxVal) SDG"
        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)

        // Set some of UIDatePicker properties
        datePicker.timeZone = NSTimeZone.local
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: +1, to: Date())

        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        let toolDateBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissDatePicker))

        chargeDate.inputAccessoryView = toolDateBar
    }

    @objc func dismissDatePicker() {

        if let date = selectedDateIs {
            self.chargeDate.text = "\(date)"
        }

        view.endEditing(true)

    }
    

    @objc func datePickerValueChanged(_ sender: UIDatePicker){

       // Create date formatter
       let dateFormatter: DateFormatter = DateFormatter()

       // Set date format
       dateFormatter.dateFormat = "yyyy/MM/dd"

       // Apply date format
       let selectedDate: String = dateFormatter.string(from: sender.date)
       self.selectedDateIs = selectedDate
       print("Selected value \(selectedDate)")
   }
    
    
    func configerImagePicer() {
        config.isScrollToChangeModesEnabled = false
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = false
        config.shouldSaveNewPicturesToAlbum = false
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo]
        config.showsCrop = .rectangle(ratio: 1.0)
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        
        config.library.options = nil
        config.library.onlySquare = false
        config.library.minWidthForItem = nil
        config.library.mediaType = YPlibraryMediaType.photo
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = false
        // Do any additional setup after loading the view.
    }
    
    func setupContentType() {
        if contentType == .wight {
            wight.isEnabled = true
            circles.isEnabled = false
            circles.text = nil
        }else {
            circles.isEnabled = true
            wight.isEnabled = false
            wight.text = nil
        }
    }
    
    func openCamera() {
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                if let img = photo.modifiedImage {
                    self.images.append(img)
                }else {
                    let img = photo.originalImage
                    self.images.append(img)
                }
            }
            self.imagesCollectionView.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func contentTypeWight() {
        contentType = .wight
        setupContentType()
        wightBtn.backgroundColor = UIColor(named: "PrimaryColor")
        circlesBtn.backgroundColor = .systemBackground
    }
    
    @IBAction func contentTypeCircles() {
        contentType = .circles
        setupContentType()
        circlesBtn.backgroundColor = UIColor(named: "PrimaryColor")
        wightBtn.backgroundColor = .systemBackground
    }

    @IBAction func picLocationForPickUp() {
        picLocationFor = .picUp
        self.performSegue(withIdentifier: "picLocation", sender: nil)
    }
    
    
    @IBAction func picLocationForDropOff() {
        picLocationFor = .dropOff
        self.performSegue(withIdentifier: "picLocation", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "picLocation" {
            let vc = segue.destination as! PicAddressViewController
            vc.delegate = self
        }
        // Pass the selected object to the new view controller.
    }

}

extension CreateOrderViewController: PicLocation {
    func picAdd(location: CLLocationCoordinate2D) {
        if picLocationFor == .picUp {
            self.picUpLacation = location
            self.picUp.text = "\(location.latitude) - \(location.longitude)"
        }else {
            self.dropOffLacation = location
            self.dropOff.text = "\(location.latitude) - \(location.longitude)"
        }
    }
}

extension CreateOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        if indexPath.item != images.count {
            cell.imageView.image = self.images[indexPath.row - 1]
            cell.trushBtn.isHidden = false
            cell.remove = {
                self.images.remove(at: indexPath.row)
                self.imagesCollectionView.reloadData()
            }
        }else {
            cell.imageView.image = UIImage(named: "no-image")
            cell.trushBtn.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == images.count {
            openCamera()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height
        return .init(width: size, height: size)
    }
}
