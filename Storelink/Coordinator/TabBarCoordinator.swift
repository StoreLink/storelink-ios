//
//  TabBarCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 14.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import Hero

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = MainTabBarController()
        tabBarController.modalPresentationStyle = .overFullScreen
        tabBarController.coordinator = self
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.hero.isEnabled = true
        mainNavigationController.heroNavigationAnimationType = .cover(direction: .up)
        mainNavigationController.tabBarItem.image = Assets.tabMain.image
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController)
        
        let storageNavigationController = UINavigationController()
        storageNavigationController.tabBarItem.image = Assets.tabStorage.image
        let storageCoordinator = StorageCoordinator(navigationController: storageNavigationController)
        
        let addController = AddViewController()
        addController.tabBarItem.image = Assets.tabAdd.image.withRenderingMode(.alwaysOriginal)
        addController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let messagesNavigationController = UINavigationController()
        messagesNavigationController.tabBarItem.image = Assets.tabMessage.image
        let messagesCoordinator = MessagesCoordinator(navigationController: messagesNavigationController)
        
        let profileNavigationContoller = UINavigationController()
        profileNavigationContoller.tabBarItem.image = Assets.tabProfile.image
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationContoller)
        
        tabBarController.viewControllers = [
            mainNavigationController,
            storageNavigationController,
            addController,
            messagesNavigationController,
            profileNavigationContoller]
        
        navigationController.present(tabBarController, animated: false, completion: nil)
        
        coordinate(to: mainCoordinator)
        coordinate(to: storageCoordinator)
        coordinate(to: messagesCoordinator)
        coordinate(to: profileCoordinator)
    }

}
