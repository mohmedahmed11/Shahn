//
//  OrdersPresenter.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/15/23.
//

import Foundation
import SwiftyJSON
import ProgressHUD

protocol OrdersListDelegate {
    func didReciveOrders(with result: Result<JSON, Error>)
}

class OrdersPresenter {
    var ordersViewController: OrdersListDelegate?
    
    convenience init(_ viewController: OrdersListDelegate) {
        self.init()
        self.ordersViewController = viewController
    }
    
    func getOrders() {
        guard let request = Glubal.getOrders(userId: UserDefaults.standard.integer(forKey: "userIsIn")).getRequest() else {return}
        startProgress()
        NetworkManager.instance.request(with: request, decodingType: JSON.self, errorModel: ErrorModel.self) { [weak self] result in
            guard let self = self else { return }
            self.stopProgress()
            switch result {
            case .success(let data):
                self.ordersViewController?.didReciveOrders(with: .success(data))
            case .failure(let error):
                self.ordersViewController?.didReciveOrders(with: .failure(error))
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
