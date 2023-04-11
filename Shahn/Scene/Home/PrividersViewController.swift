//
//  PrividersViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/11/23.
//

import UIKit

class ProvidersViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typesSegment: UISegmentedControl!
    @IBOutlet weak var providersSegment: UISegmentedControl!
    @IBOutlet weak var citiesCollectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchView()
        self.setupSegments()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSearchView() {
        searchBar.placeholder = "بحث"
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "إلغاء"
        searchBar.searchTextField.font = UIFont(name: "BahijJanna", size: 16)
        searchBar.backgroundImage = UIImage()
    }
    
    func setupSegments() {
        let seperatorImage = UIImage(named: "line")
        typesSegment.setDividerImage(seperatorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        providersSegment.setDividerImage(seperatorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "BahijJanna", size: 16) ?? .systemFont(ofSize: 16)]
        typesSegment.setTitleTextAttributes(fontAttributes, for: .normal)
        providersSegment.setTitleTextAttributes(fontAttributes, for: .normal)
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

extension ProvidersViewController: UISearchBarDelegate, UISearchTextFieldDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchbarCancelBtn(status: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showSearchbarCancelBtn(status: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showSearchbarCancelBtn(status: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        showSearchbarCancelBtn(status: false)
    }
    
    private func showSearchbarCancelBtn(status: Bool) {
        if status == false {
            self.view.endEditing(status)
        }
        self.navigationController?.setNavigationBarHidden(status, animated: true)
        searchBar.setShowsCancelButton(status, animated: true)
    }
}

extension ProvidersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}


extension ProvidersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
