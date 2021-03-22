//
//  Storage.swift
//  Storelink
//
//  Created by Акан Акиш on 18.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

struct StorageItem {
    let id: Int
    let name: String
    let description: String
    let price: Int
    let size: Int
    let location: String
    let publishTime: String
    let availableTime: String
    let images: [String]
    let type: String
}
