//
//  LoginRequest.swift
//  Storelink
//
//  Created by Акан Акиш on 26.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
    
    // To encode object
    var parameters: [String: Any] {
        do {
            let data: Data = try JSONEncoder().encode(self)
            let json: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
