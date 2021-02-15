//
//  AddCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol AddFlow: class {
    
}

class AddCoordinator: Coordinator, AddFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = AddViewController()
        viewController.coordinator = self
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Flow Methods
    
}
