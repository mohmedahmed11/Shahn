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

protocol PricingOffersStatusDelegate {
    func didStatusChanged(with result: Result<JSON, Error>)
}

class OrdersPresenter {
    var ordersViewController: OrdersListDelegate?
    var pricingViewController: PricingOffersStatusDelegate?
    
    convenience init(_ viewController: OrdersListDelegate) {
        self.init()
        self.ordersViewController = viewController
    }
    
    
    convenience init(_ viewController: PricingOffersStatusDelegate) {
        self.init()
        self.pricingViewController = viewController
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
    
    func changeOfferStatus(offerId: Int, orderId: Int, status: Int, paymentType: Int) {
        guard let request = Glubal.offersStatus.getRequest(parameters: ["offer_id": "\(offerId)", "order_id": "\(orderId)", "status": "\(status)", "payment_type": "\(paymentType)"]) else {return}
        startProgress()
        NetworkManager.instance.request(with: request, decodingType: JSON.self, errorModel: ErrorModel.self) { [weak self] result in
            guard let self = self else { return }
            self.stopProgress()
            switch result {
            case .success(let data):
                self.pricingViewController?.didStatusChanged(with: .success(data))
            case .failure(let error):
                self.pricingViewController?.didStatusChanged(with: .failure(error))
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
