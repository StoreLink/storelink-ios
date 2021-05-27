//
//  LoginCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 17.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol LoginFlow: class {
    
}

class LoginCoordinator: Coordinator, LoginFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        viewController.coordinator = self
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: { [weak self] in
            self?.navigationController = viewController.navigationController
        })
    }
    
    // MARK: - Flow Methods
    
}
