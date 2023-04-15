//
//  CreateOrderPresenter.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/15/23.
//

import Foundation
import SwiftyJSON
import ProgressHUD
import Alamofire

protocol CreateOrderViewDelegate {
    func didCreateOrder(with result: Result<JSON, Error>)
}

class CreateOrderPresenter {
    var viewController: CreateOrderViewDelegate?
    
    convenience init(_ viewController: CreateOrderViewDelegate) {
        self.init()
        self.viewController = viewController
    }
    
    func createOrder(with data: MultipartFormData) {
        startProgress()
        NetworkManager.instance.requestWithFiles(with: data, to: "\(Glubal.baseurl.path)\(Glubal.createOrder.path)", headers: Glubal.baseurl.mutipartHeaders, decodingType: JSON.self, errorModel: ErrorModel.self) { [weak self] result in
            guard let self = self else { return }
            self.stopProgress()
            switch result {
            case .success(let data):
                self.viewController?.didCreateOrder(with: .success(data))
            case .failure(let error):
                self.viewController?.didCreateOrder(with: .failure(error))
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
