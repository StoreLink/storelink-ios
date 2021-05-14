//
//  MainCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol MainFlow: class {
    func showStorageDescriptionView(storageItem: StorageItem)
    func showStorageLocationView(latitude: Double, longitude: Double)
    func showMapView(storages: [StorageItem])
    func closeMapView()
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
    func showStorageDescriptionView(storageItem: StorageItem) {
        let viewModel = StorageDescriptionViewModel(storageItem: storageItem)
        let viewController = StorageDescriptionViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showStorageLocationView(latitude: Double, longitude: Double) {
        let viewController = StorageLocationViewController(latitude: latitude, longitude: longitude)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showMapView(storages: [StorageItem]) {
        let viewController = MapViewController(storages: storages)
        viewController.coordinator = self
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func closeMapView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
