//
//  String+Extension.swift
//  Storelink
//
//  Created by Акан Акиш on 14.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

extension String {
    mutating func addSymbol(symbol: String) {
        self = self + " " + symbol
    }
}
