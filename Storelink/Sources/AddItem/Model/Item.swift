//
//  Item.swift
//  Storelink
//
//  Created by Акан Акиш on 28.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let id: Int
    let name: String
    let description: String
    let image: String?
    let size: Int
    let count: Int
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id = "itemId"
        case name = "itemName"
        case description = "itemDescription"
        case image = "itemImage"
        case count = "itemCount"
        case size = "itemSize"
        case createdDate
    }
}
