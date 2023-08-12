//
//  ProviderDetailsViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/11/23.
//

import UIKit
import SwiftyJSON
import ImageSlideshow
import Kingfisher

class ProviderDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    var sliderImages: [KingfisherSource] = []
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var totalProviders: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet var rateStars: [UIImageView]!
    @IBOutlet weak var reveiwsStack: UIStackView!
    
    var provider: JSON!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        self.sliderImages = []
        for image in provider["images"].arrayValue {
            self.sliderImages.append(KingfisherSource(urlString: Glubal.imageBaseurl.path+image["image"].stringValue)!)
        }
        setupSlider(sliderImages: sliderImages)
        
        name.text = provider["name"].string
        city.text = provider["city"].string
        details.text = provider["details"].string
        totalProviders.text = "يوجد \(provider["total_drivers"].stringValue) مزود خدمة فرعي"
        type.text = provider["type"].stringValue+" - حمولة "+provider["load_type"].stringValue
        
        for star in rateStars {
            if star.tag <= provider["rate"].intValue {
                star.image = UIImage(named: "star-fill")
            }else {
                star.image = UIImage(named: "star")
            }
        }
        
        if !provider["reviews"].arrayValue.isEmpty {
            self.reveiwsStack.isHidden = false
            for review in provider["reviews"].arrayValue {
                let reviewView = ReviewView()
                reviewView.setData(review: review)
                self.reveiwsStack.addArrangedSubview(reviewView)
            }
        }else {
            self.reveiwsStack.isHidden = true
        }
    }
    
    func setupSlider(sliderImages: [KingfisherSource]) {
        imageSlideShow.slideshowInterval = 5.0
        imageSlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 0)) //.customBottom(padding: 0))
        imageSlideShow.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        imageSlideShow.pageIndicator = pageControl
        imageSlideShow.contentScaleMode = .scaleToFill
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        imageSlideShow.setImageInputs(sliderImages)
        
        DispatchQueue.main.async {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
            self.imageSlideShow.addGestureRecognizer(recognizer)
        }
    }
    
    @objc func didTap() {
        let fullScreenController = imageSlideShow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.large, color: nil)
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
