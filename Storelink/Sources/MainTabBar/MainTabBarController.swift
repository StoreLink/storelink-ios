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
    private let vc5 = UINavigationController(rootViewController: ProfileViewController(viewModel: ProfileViewModel()))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        tabBar.tintColor = Colors.teal.color
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
        vc1.title = Strings.main
        vc1.tabBarItem.image = Assets.tabMain.image
        vc2.title = Strings.favorites
        vc2.tabBarItem.image = Assets.tabFavorite.image
        vc3.title = Strings.storage
        vc3.tabBarItem.image = Assets.tabStorage.image
        vc4.title = Strings.messages
        vc4.tabBarItem.image = Assets.tabMessage.image
        vc5.title = Strings.profile
        vc5.tabBarItem.image = Assets.tabProfile.image
    }

}
