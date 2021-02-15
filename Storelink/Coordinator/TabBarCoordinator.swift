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
        tabBarController.coordinator = self
        
        //    private func setupViewControllers() {
        //        vc1.title = Strings.main
        //        vc1.tabBarItem.image = Assets.tabMain.image
        //        vc2.title = Strings.favorites
        //        vc2.tabBarItem.image = Assets.tabFavorite.image
        //        vc3.title = Strings.storage
        //        vc3.tabBarItem.image = Assets.tabStorage.image
        //        vc4.title = Strings.messages
        //        vc4.tabBarItem.image = Assets.tabMessage.image
        //        vc5.title = Strings.profile
        //        vc5.tabBarItem.image = Assets.tabProfile.image
        //    }
        
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
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false, completion: nil)
        
        coordinate(to: mainCoordinator)
        coordinate(to: storageCoordinator)
        coordinate(to: addCoordinator)
        coordinate(to: messagesCoordinator)
        coordinate(to: profileCoordinator)
    }

}
