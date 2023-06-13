//
//  AboutModels.swift
//  Kaar
//
//  Created by Mohamed Ahmed on 2/15/23.
//

import Foundation

struct About: Codable {
    let id: Int
    let whatsapp: Int
    let instagram: String
    let snapchat: String
    let twitter: String
    let about: String
    let phone: Int
}

struct SMS: Codable {
    let id: Int
    let sender: String
    let username: String
    let password: String
    let admin: Int
}


struct AboutResponse:Codable {
    let operation: Bool
    let sms: SMS
    let about: About
}
