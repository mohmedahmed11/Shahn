//
//  UserModel.swift
//  Saadc
//
//  Created by Mohamed Ahmed on 12/17/22.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String?
    var phone: String?
    var contact: String?
    var image: String?
    var identity: String?
    var userIdentity: UserFiles?
    
    init(id: String, name: String, phone: String, contact: String? = nil, image: String? = nil, identity: String? = nil, action: String = "login", userIdentity: UserFiles? = nil) {
        self.id = id
        self.name = name
        self.phone = phone
        self.contact = contact
        self.action = action
        self.image = image
        self.userIdentity = userIdentity
        self.identity = identity
    }
    
    var userCode = 0000
    var action: String = "login"
    
}

struct AuthResponse: Codable {
    let operation: Bool
    let user: User?
}

struct UserFiles: Codable {
    var file: Data
    var name: String
    var type: String
}

