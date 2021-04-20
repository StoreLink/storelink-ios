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
    let price: Int
    let size: Int
    let availableTime: String
    let location: String?
    let createdDate: String?
//    let images: [String]?
    let image: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "storageId"
        case name = "storageName"
        case description = "storageDescription"
        case availableTime = "storageAvailableTime"
        case price = "storagePrice"
        case size = "storageSize"
        case image = "storageImage"
//        case images
        case location, createdDate, type
    }
}

//"storageId": 1,
//"storageName": "der",
//"storageDescription": "qwe",
//"storageAvailableTime": "24/7 hour",
//"storageImage": "qwe",
//"storagePrice": null,
//"storageSize": null,
//"storageLongitude": null,
//"storageLatitude": null,
//"createdDate": null,
