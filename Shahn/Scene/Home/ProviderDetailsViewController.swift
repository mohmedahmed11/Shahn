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
    
    @IBOutlet weak var reveiwsStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        for _ in 0...5 {
            let reviewView = ReviewView()
//            reviewView.setData(review: review)
            self.reveiwsStack.addArrangedSubview(reviewView)
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
