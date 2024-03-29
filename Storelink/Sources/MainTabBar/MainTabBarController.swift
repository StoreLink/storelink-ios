//
//  MainTabBarController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/14/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    var coordinator: TabBarFlow?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        tabBar.tintColor = Colors.teal.color
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let items = tabBar.items {
            for item in items {
                item.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            }
        }
    }
}

// MARK: UITabbar Delegate

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddPopupViewController.self) {
            coordinator?.showAddPopupView()
            return false
        }
        return true
    }
}
