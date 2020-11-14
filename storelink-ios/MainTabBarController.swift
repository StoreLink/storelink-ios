//
//  MainTabBarController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/14/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // TODO: set real view controllers
    private let vc1 = UINavigationController(rootViewController: InitialViewController())
    private let vc2 = UINavigationController(rootViewController: InitialViewController())
    private let vc3 = UINavigationController(rootViewController: InitialViewController())
    private let vc4 = UINavigationController(rootViewController: InitialViewController())
    private let vc5 = UINavigationController(rootViewController: InitialViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        tabBar.tintColor = UIColor(named: "teal")
        viewControllers = [vc1, vc2, vc3, vc4, vc5]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let items = tabBar.items {
            for item in items {
                item.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            }
        }
    }
    
    private func setupViewControllers() {
        vc1.title = "Объвления"
        vc1.tabBarItem.image = UIImage(named: "tab_search")
        vc2.title = "Избранное"
        vc2.tabBarItem.image = UIImage(named: "tab_favorite")
        vc3.title = "Хранилище"
        vc3.tabBarItem.image = UIImage(named: "tab_storage")
        vc4.title = "Сообщения"
        vc4.tabBarItem.image = UIImage(named: "tab_inbox")
        vc5.title = "Профиль"
        vc5.tabBarItem.image = UIImage(named: "tab_profile")
    }

}
