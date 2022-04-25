//
//  UIAlertController+Extension.swift
//  Storelink
//
//  Created by Акан Акиш on 19.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
