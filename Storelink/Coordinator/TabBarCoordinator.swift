//
//  TabBarCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 14.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

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
        mainNavigationController.tabBarItem.image = Assets.tabMain.image
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController)
        
        let storageNavigationController = UINavigationController()
        storageNavigationController.tabBarItem.image = Assets.tabStorage.image
        let storageCoordinator = StorageCoordinator(navigationController: storageNavigationController)
        
        let addNavigationController = UINavigationController()
        addNavigationController.tabBarItem.image = Assets.tabAdd.image
        let addCoordinator = AddCoordinator(navigationController: addNavigationController)
        
        let messagesNavigationController = UINavigationController()
        messagesNavigationController.tabBarItem.image = Assets.tabMessage.image
        let messagesCoordinator = MessagesCoordinator(navigationController: messagesNavigationController)
        
        let profileNavigationContoller = UINavigationController()
        profileNavigationContoller.tabBarItem.image = Assets.tabProfile.image
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationContoller)
        
        tabBarController.viewControllers = [
            mainNavigationController,
            storageNavigationController,
            addNavigationController,
            messagesNavigationController,
            profileNavigationContoller]
        
        navigationController.present(tabBarController, animated: false, completion: nil)
        
        coordinate(to: mainCoordinator)
        coordinate(to: storageCoordinator)
        coordinate(to: addCoordinator)
        coordinate(to: messagesCoordinator)
        coordinate(to: profileCoordinator)
    }

}
