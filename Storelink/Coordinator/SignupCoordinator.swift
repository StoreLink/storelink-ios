//
//  SignupCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 17.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol SignupFlow: class {
    func showOTPView(phoneNumber: String)
}

class SignupCoordinator: Coordinator, SignupFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SignupPhoneViewController()
        viewController.coordinator = self
        viewController.modalPresentationStyle = .formSheet
        navigationController?.present(UINavigationController(rootViewController: viewController), animated: true, completion: { [weak self] in
            self?.navigationController = viewController.navigationController
        })
    }
    
    // MARK: - Flow Methods
    func showOTPView(phoneNumber: String) {
        let viewModel = SignupOTPViewModel(phoneNumber: phoneNumber)
        let viewController = SignupOTPViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
