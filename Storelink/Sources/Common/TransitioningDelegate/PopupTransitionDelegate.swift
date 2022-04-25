//
//  PopupTransitionDelegate.swift
//  Storelink
//
//  Created by Акан Акиш on 16.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class PopupTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source _: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
