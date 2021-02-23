//
//  MainCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol MainFlow: class {
   func showStorageDescriptionView()
}

class MainCoordinator: Coordinator, MainFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func showStorageDescriptionView() {
        let viewModel = StorageDescriptionViewModel()
        let viewController = StorageDescriptionViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
