//
//  StorageItemRequest.swift
//  Storelink
//
//  Created by Акан Акиш on 20.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct StorageItemRequest: Encodable {
    let name: String
    let description: String
    let price: Int
    let size: Int
    let availableTime: String
    let location: String?
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name = "storageName"
        case description = "storageDescription"
        case availableTime = "storageAvailableTime"
        case price = "storagePrice"
        case size = "storageSize"
        case image = "storageImage"
        case location
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
