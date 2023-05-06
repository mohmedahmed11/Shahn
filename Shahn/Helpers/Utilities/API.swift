//
//  API.swift
//  Poster
//
//  Created by MAC on 01/01/2019.
//  Copyright © 2019 MAC. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum DataLayerError<E: Error & Decodable>: Error  {
    case backend (E)
    case network(String)
    case parsing(String, Int)
}

public class NetworkManager {
    
    static var instance = NetworkManager()
    
    /*
     func getAll()
     use to get all data from server
     with parameters:
     - endurl: where data will be send
     
     + onCompletion: when get is success
     + onError: when get is failure
     */
    
    func request<T: Decodable, E: Error & Decodable>(with request: URLRequest, decodingType: T.Type, errorModel: E.Type, completion: @escaping (Result<T, DataLayerError<E>>) -> Void){
        
        AF.request(request).response { response in
            
            do {
                guard let httpResponse = response.response else {
                        completion(Result.failure(DataLayerError.network("bad request")))
                        return
                }
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode <= 600) {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    
                    guard let data = response.data else {
                            completion(Result.failure(DataLayerError.network("bad request")))
                            return
                    }
                    
                    let object = try JSONDecoder().decode(errorModel.self, from: data)
                    completion(Result.failure(DataLayerError.backend(object)))
                        
                }
                else if httpResponse.statusCode == 200 {
                    switch response.result {
                    case .success(let data):
                        guard let resultData = data else {
                                completion(Result.failure(DataLayerError.network("bad request")))
                                return
                        }
                        let object = try JSONDecoder().decode(decodingType.self, from: resultData)
                        completion(Result.success(object))
                    case .failure(let error):
                        completion(Result.failure(DataLayerError.network(error.localizedDescription)))
                    }
                }
            }catch {
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    completion(Result.failure(DataLayerError.parsing(error.localizedDescription, httpResponse.statusCode)))
                }
            }
        }
    }

    func requestWithFiles<T: Decodable, E: Error & Decodable>(with multipartFormData: MultipartFormData, to url: String, headers: HTTPHeaders, decodingType: T.Type, errorModel: E.Type, completion: @escaping (Result<T, DataLayerError<E>>) -> Void){
        
        AF.upload(multipartFormData: multipartFormData,to: url,method: .post, headers: headers).response { response in
            
            do {
                guard let httpResponse = response.response else {
                        completion(Result.failure(DataLayerError.network("bad request")))
                        return
                }
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode <= 600) {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    
                    guard let data = response.data else {
                            completion(Result.failure(DataLayerError.network("bad request")))
                            return
                    }
                    
                    let object = try JSONDecoder().decode(errorModel.self, from: data)
                    completion(Result.failure(DataLayerError.backend(object)))
                        
                }
                else if httpResponse.statusCode == 200 {
                    switch response.result {
                    case .success(let data):
                        guard let resultData = data else {
                                completion(Result.failure(DataLayerError.network("bad request")))
                                return
                        }
                        let object = try JSONDecoder().decode(decodingType.self, from: resultData)
                        completion(Result.success(object))
                    case .failure(let error):
                        completion(Result.failure(DataLayerError.network(error.localizedDescription)))
                    }
                }
            }catch {
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    completion(Result.failure(DataLayerError.parsing(error.localizedDescription, httpResponse.statusCode)))
                }
            }
        }
    }
    func request<T: Decodable, E: Error & Decodable>(with url: String, method: HTTPMethod = .get, parameters: [String: Any], decodingType: T.Type, errorModel: E.Type, completion: @escaping (Result<T, DataLayerError<E>>) -> Void){
        print(url)
        print(parameters)
        AF.request(url,method: method ,parameters: parameters).response { response in
         print(response)
            do {
                guard let httpResponse = response.response else {
                        completion(Result.failure(DataLayerError.network("bad request")))
                        return
                }
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode <= 600) {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    
                    guard let data = response.data else {
                            completion(Result.failure(DataLayerError.network("bad request")))
                            return
                    }
                    
                    let object = try JSONDecoder().decode(errorModel.self, from: data)
                    completion(Result.failure(DataLayerError.backend(object)))
                        
                }
                else if httpResponse.statusCode == 200 {
                    switch response.result {
                    case .success(let data):
                        guard let resultData = data else {
                                completion(Result.failure(DataLayerError.network("bad request")))
                                return
                        }
                        let object = try JSONDecoder().decode(decodingType.self, from: resultData)
                        completion(Result.success(object))
                    case .failure(let error):
                        completion(Result.failure(DataLayerError.network(error.localizedDescription)))
                    }
                }
            }catch {
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    completion(Result.failure(DataLayerError.parsing(error.localizedDescription, httpResponse.statusCode)))
                }
            }
        }
    }
    
    
    func postWithArrayOfFiles<T: Decodable, E: Error & Decodable>(with url: String,filesData: [Data],withName: [String], mimeType: [String],  method: HTTPMethod = .post, parameters: [String: Any], decodingType: T.Type, errorModel: E.Type, completion: @escaping (Result<T, DataLayerError<E>>) -> Void){
        print(url)
        print(parameters)
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            
            for index in 0..<filesData.count {
                multipartFormData.append(filesData[index], withName: "files[\(index)]",fileName: withName[index], mimeType: mimeType[index])
            }
        },to: url,method: method, headers: headers).response { response in
        
            do {
                guard let httpResponse = response.response else {
                        completion(Result.failure(DataLayerError.network("bad request")))
                        return
                }
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode <= 600) {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    
                    guard let data = response.data else {
                            completion(Result.failure(DataLayerError.network("bad request")))
                            return
                    }
                    
                    let object = try JSONDecoder().decode(errorModel.self, from: data)
                    completion(Result.failure(DataLayerError.backend(object)))
                        
                }
                else if httpResponse.statusCode == 200 {
                    switch response.result {
                    case .success(let data):
                        guard let resultData = data else {
                                completion(Result.failure(DataLayerError.network("bad request")))
                                return
                        }
                        let object = try JSONDecoder().decode(decodingType.self, from: resultData)
                        completion(Result.success(object))
                    case .failure(let error):
                        completion(Result.failure(DataLayerError.network(error.localizedDescription)))
                    }
                }
            }catch {
                if let httpResponse = response.response {
                    if httpResponse.statusCode == 401 {
                        print("UnAuthorized ")
                        self.handleUnAuthorizedUser()
                        return
                    }
                    completion(Result.failure(DataLayerError.parsing(error.localizedDescription, httpResponse.statusCode)))
                }
            }
        }
    }
    
    
    open func downloadFileData(with endUrl: String, onCompletion: ((Data) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        AF.request(endUrl, method: .get).response{ response in
            print(response)
            switch response.result {
            case .success(let result):
                guard let resultData = result else {
                    let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                    onError!(err)
                    return
                }
                onCompletion?(resultData)
            case .failure(let err):
                print("Error : \(err.localizedDescription)")
                onError?(err)
            }
        }
    }
    

    open func getAllByDictionary(endUrl: String, onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        AF.request(endUrl, method: .get).response{ response in
            switch response.result {
            case .success(let result):
                guard let result = result else {
                    let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                    onError!(err)
                    return
                }
                guard let json = JSON(result).dictionary else{
                    let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                    onError!(err)
                    return
                }
                
                onCompletion?(json)
            case .failure(let err):
                print("Error : \(err.localizedDescription)")
                onError?(err)
            }
        }
    }
    
    open func postAllByDictionary(endUrl: String, params: Parameters, onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        print(params)
        
        AF.request(endUrl, method: .post, parameters: params, headers: headers).response{ response in
            print(response)
            switch response.result {
            case .success(let result):
                
//                print(result
                guard let result = result else {
                    let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                    onError!(err)
                    return
                }
                
                guard let json = JSON(result).dictionary else{
                    let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                    onError!(err)
                    return
                }
                
                onCompletion?(json)
            case .failure(let err):
                print("Error : \(err.localizedDescription)")
                onError?(err)
            }
        }
    }
    
    /*
     func postWithFile()
     use to uploade file
     with parameters:
     - endurl: where data will be send
     - fileData: specific data representation of file to be send
     - withName: file name
     - parameters: othr parameters need to send with
     
     + onCompletion: when upload is success
     + onError: when upload is failure
     */
    
    public func postWithFile(endUrl: String, fileData: Data?,withName: String, mimeType: String, parameters: [String : Any], onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if let data = fileData {
                multipartFormData.append(data, withName: "file",fileName: withName, mimeType: mimeType)
            }
        },
                  to: endUrl, method: .post , headers: headers)
            .response(completionHandler: { (response) in
                print(response.result)
                switch response.result {
                case .success(let result):
                    guard let json = JSON(result!).dictionary else{
                        let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                        onError!(err)
                        return
                    }
                    
                    onCompletion?(json)
                case .failure(let err):
                    print("Error : \(err.localizedDescription)")
                    onError?(err)
                }
            })
    }
    
    
    public func postWithArrayOfFiles(endUrl: String, fileData: [Data],withName: String, mimeType: String, parameters: [String : Any], onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            
            for index in 0..<fileData.count {
                multipartFormData.append(fileData[index], withName: "files[\(index)]",fileName: withName, mimeType: mimeType)
            }
        },
                  to: endUrl, method: .post , headers: headers)
            .response(completionHandler: { (response) in
                print(response.result)
                switch response.result {
                case .success(let result):
                    guard let result = result else{
                        let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                        onError!(err)
                        return
                    }
                    guard let json = JSON(result).dictionary else{
                        let err = NSError(domain: "\(endUrl)", code: 1, userInfo: [NSLocalizedDescriptionKey: "not in good format json"])
                        onError!(err)
                        return
                    }
                    
                    onCompletion?(json)
                case .failure(let err):
                    print("Error : \(err.localizedDescription)")
                    onError?(err)
                }
            })
    }
    
    /*
     func uploadFile()
     use to uploade file
     with parameters:
     - endurl: where data will be send
     - fileData: specific data representation of file to be send
     - withName: file name
     - parameters: othr parameters need to send with
     
     + onCompletion: when upload is success
     + onError: when upload is failure
     */
    
    public func uploadFile(endUrl: String, fileData: Data?,withName: String, mimeType: String, parameters: [String : Any], onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if let data = fileData {
                multipartFormData.append(data, withName: "file",fileName: withName, mimeType: mimeType)
            }
        },
                  to: endUrl, method: .post , headers: headers)
            .response(completionHandler: { (response) in
                
                print(response)
                
                if let err = response.error{
                    print(err)
                    onError?(err)
                    return
                }
                onCompletion?(response.value ?? nil)
            })
    }
    /*
     func dwonloadImage()
     use to dwonload images
     with parameters:
     - endurl: where data will be send
     
     + onCompletion: when dwonload is success
     + onError: when dwonload is failure
     */
    
    func downloadImage(endUrl: String, onCompletion: ((UIImage?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        AF.request(endUrl).responseImage { response in
            switch response.result {
            case .success:
                if let image = response.value{
                    onCompletion?(image)
                }
            case .failure(let err):
                print("\(err.localizedDescription)")
                onError?(err)
            }
        }
    }
}

extension NetworkManager {
    
    func handleUnAuthorizedUser() {
        
        let standard = UserDefaults.standard
        
        let domain = Bundle.main.bundleIdentifier!
        standard.removePersistentDomain(forName: domain)
        standard.synchronize()
        DispatchQueue.main.async {
            self.navigateToMain(StoryboardName: "Main", IdentifierName: "LoginNavigationController")
            
        }
    }
    
    func navigateToMain(StoryboardName: String ,IdentifierName : String) {
        let main = UIStoryboard(name: StoryboardName, bundle: nil).instantiateViewController(withIdentifier: IdentifierName)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = main
            
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
protocol Endpoint {
    var base: String { get }
    var baseImages: String { get }
    var path: String { get }
    var normalHeaders: HTTPHeaders { get }
    var mutipartHeaders: HTTPHeaders { get }
}

extension Endpoint {
    var request: URLRequest? {
        guard let url = URL(string: "\(self.base)\(self.path)") else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    func postRequest<T: Encodable>(parameters: T) -> URLRequest? {
        guard let url = URL(string: "\(self.base)\(self.path)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
           return nil
        }
        normalHeaders.forEach { request.addValue("\($0.value)", forHTTPHeaderField: $0.name) }
        return request
    }
    
    
    func postMultipartRequest(with boundary: String) -> URLRequest? {
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func getRequest(parameters: [String: String]? = nil) -> URLRequest? {
        guard var components = URLComponents(string: "\(self.base)\(self.path)") else { return nil }
        if let parameters = parameters {
            components.setQueryItems(with: parameters)
        }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        normalHeaders.forEach { request.addValue("\($0.value)", forHTTPHeaderField: $0.name) }
        return request
        
    }
    
    func putRequest<T: Encodable>(parameters: T) -> URLRequest? {
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethod.put.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            return nil
        }
        normalHeaders.forEach { request.addValue("\($0.value)", forHTTPHeaderField: $0.name) }
        return request
    }
    
    func deleteRequest<T: Encodable>(parameters: T) -> URLRequest? {
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethod.delete.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            return nil
        }
        normalHeaders.forEach { request.addValue("\($0.value)", forHTTPHeaderField: $0.name) }
        return request
    }
}

enum Glubal {
    case baseurl
    case imageBaseurl
    case filesBaseurl
    case about
    case users
    case getUser
    case cities
    case categories
    case sms
    case providers
    case createOrder
    case getOrders(userId: Int)
    case offersStatus
}

extension Glubal: Endpoint {
    var base: String {
        return "https://shahen1.com/shahen_app/"
    }
    
    var baseImages: String {
        return "https://shahen1.com/shahen_app/images/"
    }
    
    var baseFiles: String {
        return "https://shahen1.com/shahen_app/files/"
    }
    
    var path: String {
        switch self {
        case .baseurl:
            return self.base
        case .imageBaseurl:
            return self.baseImages
        case .filesBaseurl:
            return self.baseFiles
        case .about:
            return "show/about.php"
        case .users:
            return "write/users.php"
        case .getUser:
            return "show/user.php"
        case .cities:
            return "show/cities.php"
        case .categories:
            return "show/categories.php"
        case .sms:
            return "sms_api.php"
        case .providers:
            return "show/providers.php"
        case .createOrder:
            return "write/orders.php"
        case .getOrders(let userID):
            return "show/orders.php?user_id=\(userID)&action=all"
        case .offersStatus:
            return "write/offers_status.php"
        }
    }
    
    var mutipartHeaders: HTTPHeaders {
        return [
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
    }
    
    var normalHeaders: HTTPHeaders {
        return [
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
        
    }

    
}

struct AppManager {
    static var shared = AppManager()
    var authUser: User?
    var about: About?
    var wallet: JSON?
    var sms: SMS?
    var checkFor: String = "login"
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

//let FnarDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
