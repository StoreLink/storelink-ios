//
//  AppCoordinator.swift
//  Storelink
//
//  Created by Акан Акиш on 14.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        enableGoogleMaps()
        let tabBarNavigationController = UINavigationController()
        window.rootViewController = tabBarNavigationController
        window.makeKeyAndVisible()

        let tabBarCoordinator = TabBarCoordinator(navigationController: tabBarNavigationController)
        coordinate(to: tabBarCoordinator)
    }

    private func enableGoogleMaps() {
        GMSServices.provideAPIKey(GlobalConstants.googleMapsAPIKey)
        GMSPlacesClient.provideAPIKey(GlobalConstants.googleMapsAPIKey)
    }
}
