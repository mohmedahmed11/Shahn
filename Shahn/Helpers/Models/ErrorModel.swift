//
//  ErrorModel.swift
//  Kaar
//
//  Created by Mohamed Ahmed on 2/15/23.
//

import Foundation

struct ErrorModel: Decodable, Error {
    let code: Int?
    let message: String?
    
}
