//
//  PrividersViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/11/23.
//

import UIKit
import SwiftyJSON

class ProvidersViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typesSegment: UISegmentedControl!
    @IBOutlet weak var providersSegment: UISegmentedControl!
    
    @IBOutlet weak var resultCountLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var requestBTN: UIButton!
    
    @IBOutlet weak var citiesBtn: UIButton!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var selectedCountLbl: UILabel!
    
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    
    var presenter: HomePesenter?
    
    var cities = [JSON]()
    var filtredProviders = [JSON]() {
        didSet {
            if !filtredProviders.isEmpty {
                self.resultCountLbl.text = "عدد النتائج = \(filtredProviders.count)"
                self.resultCountLbl.isHidden = false
            }else {
                self.resultCountLbl.isHidden = true
            }
        }
    }
    var providers = [JSON]()
    var selectedCategory: JSON!
    
    var selectedCityIndex = 0
    
    var selectedProviders = [JSON]() {
        didSet {
            if !selectedProviders.isEmpty {
                self.requestBTN.isEnabled = true
                self.requestBTN.backgroundColor = UIColor(named: "PrimaryColor")
            }else {
                self.requestBTN.isEnabled = false
                self.requestBTN.backgroundColor = .systemGray3
            }
            selectedCountLbl.text = "تم إختيار = \(selectedProviders.count)"
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        presenter = HomePesenter(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        citiesCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.setupSearchView()
        self.setupSegments()
        self.resultCountLbl.isHidden = true
        self.loadAll()
        // Do any additional setup after loading the view.
    }
    
    func loadAll() {
        self.presenter?.loadCities()
        self.presenter?.loadProviders(categoryId: self.selectedCategory["id"].intValue)
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
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "providerDetails" {
            let vc = segue.destination as! ProviderDetailsViewController
            vc.provider = sender as? JSON
        }else if segue.identifier == "createOrder" {
            let vc = segue.destination as! CreateOrderViewController
            vc.providers = self.selectedProviders
        }
        // Pass the selected object to the new view controller.
    }
    

}

extension ProvidersViewController: ProvidersViewDelegate {
    func didReciveCities(with result: Result<JSON, Error>) {
        switch result {
        case .success(let data):
            if data["operation"].boolValue == true {
                self.cities = data["data"].arrayValue
            }
        case .failure(let error):
            self.faildLoading(icon: UIImage(named: "reload"), content: "حدث خطأ اعد المحاولة")
            print(error)
        }
    }
    
    func didReciveProviders(with result: Result<JSON, Error>) {
        switch result {
        case .success(let data):
            if data["operation"].boolValue == true {
                self.providers = data["data"].arrayValue
                self.filtredProviders = self.providers
                if !self.providers.isEmpty {
                    self.tableView.backgroundView = nil
                    self.tableView.reloadData()
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
        error.content.text = "لا يوجد مقدمي خدمات متاحين"
        self.tableView.backgroundView = error
    }
    
    func faildLoading(icon: UIImage?, content: String) {
        let error = noUserDataNotLoadedNip(nil, content)
        error.frame = self.tabBarController?.tabBar.frame ?? .zero
        error.reloadData = {
            self.loadAll()
            error.removeFromSuperview()
        }
        self.tabBarController?.view.addSubview(error)
    }
}

extension ProvidersViewController: UISearchBarDelegate, UISearchTextFieldDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchbarCancelBtn(status: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filtredProviders = providers
        self.tableView.reloadData()
        showSearchbarCancelBtn(status: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showSearchbarCancelBtn(status: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 2 {
            filtredProviders = providers.filter({ $0["city"].stringValue == searchBar.text || $0["name"].stringValue == searchBar.text || $0["load_type"].stringValue == searchBar.text || $0["type"].stringValue == searchBar.text })
        }else {
            filtredProviders = providers
        }
        tableView.reloadData()
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

extension ProvidersViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CityCollectionViewCell
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        if indexPath.item != 0 {
            cell.name.text = cities[indexPath.item - 1]["name"].string
        }else {
            cell.name.text = "الكل"
        }
        
        if selectedCityIndex == indexPath.item {
            cell.name.backgroundColor = .systemBackground
        }else {
            cell.name.backgroundColor = .clear
        }
        
        cell.name.layer.cornerRadius = 4
        cell.name.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 80
        
        if indexPath.item != 0 {
            let str = self.cities[indexPath.item - 1]["name"].stringValue
            width = str.size(height: 34, font: .systemFont(ofSize: 18)).width + 16
        }
        
        return CGSize(width: width, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCityIndex = indexPath.item
//        self.citiesCollectionView.reloadData()
    }
}


extension ProvidersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtredProviders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProviderTableViewCell
        let provider = self.filtredProviders[indexPath.row]
        cell.setUI(with: provider)
        cell.checkedCallback = {
            if self.selectedProviders.first(where: {$0["id"].intValue == provider["id"].intValue}) != nil {
                self.selectedProviders.removeAll(where: {$0["id"].intValue == provider["id"].intValue})
            }else {
                self.selectedProviders.append(provider)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "providerDetails", sender: self.filtredProviders[indexPath.row])
    }
}

extension ProvidersViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBAction func picCity() {
        self.city.becomeFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == city {
            city.inputView = pickerView
        }
    }
    
    @IBAction func valueChanged(_ textField: UITextField) {
        if textField.text!.count > 2 {
            selectedProviders = providers.filter({ $0["city"].stringValue == textField.text || $0["name"].stringValue == textField.text || $0["load_type"].stringValue == textField.text || $0["type"].stringValue == textField.text })
        }else {
            filtredProviders = providers
        }
        tableView.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == city {
            return self.cities.count + 1
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == city {
            if row == 0 {
                return "كل المناطق"
            }else {
                return self.cities[row - 1]["name"].string
            }
                
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == city {
            if row == 0 {
                filtredProviders = providers
                self.citiesBtn.setTitle("كل المناطق", for: .normal)
            }else {
                print(self.cities[row - 1])
                filtredProviders = providers.filter({ $0["city_id"].intValue == self.cities[row - 1]["id"].intValue })
                self.citiesBtn.setTitle(self.cities[row - 1]["name"].string, for: .normal)
            }
            tableView.reloadData()
        }
        self.view.endEditing(true)
    }
}
