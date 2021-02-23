//
//  ProfileCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol ProfileFlow: class {
    func showPopupView()
    func showLoginView()
    func showSignupView()
}

class ProfileCoordinator: Coordinator, ProfileFlow {
    
    weak var navigationController: UINavigationController?
    
    private var transitioningDelegate: PopupTransitionDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func showPopupView() {
        let authorizationPopupView = ProfilePopupViewController()
        authorizationPopupView.coordinator = self
        authorizationPopupView.modalPresentationStyle = .custom
        transitioningDelegate = PopupTransitionDelegate()
        authorizationPopupView.transitioningDelegate = transitioningDelegate
        navigationController?.present(authorizationPopupView, animated: true, completion: nil)
    }
    
    func showLoginView() {
        navigationController?.dismiss(animated: true, completion: nil)
        let loginCoordinator = LoginCoordinator(navigationController: navigationController!)
        coordinate(to: loginCoordinator)
    }
    
    func showSignupView() {
        navigationController?.dismiss(animated: true, completion: nil)
        let signupCoordinator = SignupCoordinator(navigationController: navigationController!)
        coordinate(to: signupCoordinator)
    }
}
