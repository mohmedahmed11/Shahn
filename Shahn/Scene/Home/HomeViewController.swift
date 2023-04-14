//
//  HomeViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/11/23.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {
    
    var presenter: HomePesenter?
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var categories = [JSON]()
    var currentCategoryIndex = -1
    var selectedCategory: JSON!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        presenter = HomePesenter(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavJannaFont()
        self.presenter?.loadCategories()
        // Do any additional setup after loading the view.
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

extension HomeViewController: HomeViewDelegate {
    func didReciveCategories(with result: Result<JSON, Error>) {
        switch result {
        case .success(let data):
            if data["operation"].boolValue == true {
                self.categories = data["data"].arrayValue
                if !self.categories.isEmpty {
                    self.currentCategoryIndex = 0
                    self.selectedCategory = self.categories[0]
                    self.categoriesCollectionView.backgroundView = nil
                    self.categoriesCollectionView.reloadData()
                    self.nextBtn.isHidden = false
                }else {
                    self.addNoData()
                }
            }else {
                self.addNoData()
            }
        case .failure(let error):
            self.faildLoading(icon: UIImage(named: "reload"), content: "حدث خطأ اعد المحاولة")
            print(error)
        }
    }
    
    func addNoData() {
        let error = noDataFoundNip()
        error.frame.size.height = 200
        error.frame.size.width = self.categoriesCollectionView.frame.width
        error.content.text = "لا توجد أقسام متاحة"
        self.categoriesCollectionView.backgroundView = error
        self.nextBtn.isHidden = true
    }
    
    func faildLoading(icon: UIImage?, content: String) {
        let error = noUserDataNotLoadedNip(icon, content)
        error.frame = self.tabBarController!.tabBar.frame
        error.reloadData = {
            self.presenter?.loadCategories()
            error.removeFromSuperview()
        }
        self.tabBarController?.view.addSubview(error)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.setUI(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let height = scrollView.frame.height
        currentCategoryIndex = Int(scrollView.contentOffset.y / height)
        selectedCategory = categories[currentCategoryIndex]
    }
    
}
