//
//  ItemRequest.swift
//  Storelink
//
//  Created by Акан Акиш on 28.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct ItemRequest: Encodable {
    let name: String
    let description: String
    let count: Int
    let image: String
    let size: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "itemName"
        case description = "itemDescription"
        case count = "itemCount"
        case image = "itemImage"
        case size = "itemSize"
    }
    
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
