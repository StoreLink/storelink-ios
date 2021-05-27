//
//  User.swift
//  Storelink
//
//  Created by Акан Акиш on 27.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let username: String
    let email: String
    let accessToken: String
}

extension User {
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case username = "username"
        case email = "email"
        case accessToken = "accessToken"
    }
}

class UserService {
    
    static let shared = UserService()
    
    var user: User?
}
