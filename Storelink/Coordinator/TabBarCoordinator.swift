//
//  TabBarCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 14.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import Hero

protocol TabBarFlow: class {
    func showAddPopupView()
    func showAddStorageView()
    func showAddItemView()
}

class TabBarCoordinator: Coordinator, TabBarFlow {
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
        
        let addController = AddPopupViewController()
        addController.tabBarItem.image = Assets.tabAdd.image.withRenderingMode(.alwaysOriginal)
        addController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let calculatePriceNavigationController = UINavigationController()
        calculatePriceNavigationController.tabBarItem.image = Assets.tabCalculator.image
        let calculatePriceCoordinator = CalculatePriceCoordinator(navigationController: calculatePriceNavigationController)
        
        let profileNavigationContoller = UINavigationController()
        profileNavigationContoller.tabBarItem.image = Assets.tabProfile.image
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationContoller)
        
        tabBarController.viewControllers = [
            mainNavigationController,
            storageNavigationController,
            addController,
            calculatePriceNavigationController,
            profileNavigationContoller]
        
        navigationController.present(tabBarController, animated: false, completion: nil)
        
        coordinate(to: mainCoordinator)
        coordinate(to: storageCoordinator)
        coordinate(to: calculatePriceCoordinator)
        coordinate(to: profileCoordinator)
    }
    
    func showAddPopupView() {
        let topViewController = UIApplication.topViewController()
        let addPopupView = AddPopupViewController()
        addPopupView.coordinator = self
        addPopupView.modalPresentationStyle = .custom
        let transitioningDelegate = PopupTransitionDelegate()
        addPopupView.transitioningDelegate = transitioningDelegate
        topViewController?.present(addPopupView, animated: true, completion: nil)
    }
    
    func showAddStorageView() {
        let topViewController = UIApplication.topViewController()
        topViewController?.dismiss(animated: true, completion: {
            let topView = UIApplication.topViewController()
            let viewModel = AddStorageViewModel()
            let viewController = AddStorageViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            topView?.present(navigationController, animated: true, completion: nil)
        })
    }
    
    func showAddItemView() {
        let topViewController = UIApplication.topViewController()
        topViewController?.dismiss(animated: true, completion: {
            let topView = UIApplication.topViewController()
            let viewController = AddItemViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            topView?.present(navigationController, animated: true, completion: nil)
        })
    }

}
