//
//  Notification+Extension.swift
//  Storelink
//
//  Created by Акан Акиш on 27.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var loginSuccess: Notification.Name {
        return .init(rawValue: "user.login")
    }
}
