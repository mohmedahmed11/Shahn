//
//  AboutModels.swift
//  Kaar
//
//  Created by Mohamed Ahmed on 2/15/23.
//

import Foundation

struct About: Codable {
    let id: String
    let whatsapp: String
    let instagram: String
    let snapchat: String
    let twitter: String
    let about: String
    let phone: String
}

struct SMS: Codable {
    let id: String
    let sender: String
    let username: String
    let password: String
    let admin: String
}


struct AboutResponse:Codable {
    let operation: Bool
    let sms: SMS
    let about: About
}
