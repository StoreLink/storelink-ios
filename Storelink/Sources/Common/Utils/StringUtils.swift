//
//  StringUtils.swift
//  Storelink
//
//  Created by Акан Акиш on 25.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

final class StringUtils: NSObject {
    static func textWithSymbol(text: String, symbol: String) -> String {
        return text + " " + symbol
    }
}
