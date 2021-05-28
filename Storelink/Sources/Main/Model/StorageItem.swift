//
//  Storage.swift
//  Storelink
//
//  Created by Акан Акиш on 18.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct StorageItem: Decodable {
    let id: Int
    let name: String
    let description: String
    let availableTime: String
    let image: String?
    let price: Int
    let size: Int
    let longitude: Double
    let latitude: Double
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "storageId"
        case name = "storageName"
        case description = "storageDescription"
        case availableTime = "storageAvailableTime"
        case image = "storageImage"
        case price = "storagePrice"
        case size = "storageSize"
        case longitude = "storageLongitude"
        case latitude = "storageLatitude"
        case createdDate = "createdDate"
    }
}
