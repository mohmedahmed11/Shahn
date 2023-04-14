//
//  HomePresenter.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/14/23.
//

import Foundation
import SwiftyJSON
import ProgressHUD

protocol HomeViewDelegate {
    func didReciveCategories(with result: Result<JSON, Error>)
}

protocol ProvidersViewDelegate {
    func didReciveCities(with result: Result<JSON, Error>)
}


class HomePesenter {
    var homeController: HomeViewDelegate?
    var providerController: ProvidersViewDelegate?
    
    convenience init(_ viewController: HomeViewDelegate) {
        self.init()
        homeController = viewController
    }
    
    convenience init(_ viewController: ProvidersViewDelegate) {
        self.init()
        providerController = viewController
    }
    
    func loadCities() {
        guard let request = Glubal.cities.getRequest() else {return}
        startProgress()
        NetworkManager.instance.request(with: request, decodingType: JSON.self, errorModel: ErrorModel.self) { [weak self] result in
            guard let self = self else { return }
            self.stopProgress()
            switch result {
            case .success(let data):
                self.providerController?.didReciveCities(with: .success(data))
            case .failure(let error):
                self.providerController?.didReciveCities(with: .failure(error))
            }
        }
    }
    
    func loadCategories() {
        guard let request = Glubal.categories.getRequest() else {return}
        startProgress()
        NetworkManager.instance.request(with: request, decodingType: JSON.self, errorModel: ErrorModel.self) { [weak self] result in
            guard let self = self else { return }
            self.stopProgress()
            switch result {
            case .success(let data):
                self.homeController?.didReciveCategories(with: .success(data))
            case .failure(let error):
                self.homeController?.didReciveCategories(with: .failure(error))
            }
        }
    }
    
    func startProgress() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
    }
    
    func stopProgress() {
        ProgressHUD.dismiss()
    }
}
