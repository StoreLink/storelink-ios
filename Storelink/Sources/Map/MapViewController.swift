//
//  MapViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 24.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

final class MapViewController: InitialViewController {
    
    var coordinator: MainCoordinator?
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    private var placesClient: GMSPlacesClient!
    private var preciseLocationZoomLevel: Float = 15.0
    private var approximateLocationZoomLevel: Float = 10.0
    private lazy var mapView: GMSMapView = {
        // A default location to use when location permission is not granted.
        let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)

        // Create a map.
        let zoomLevel = preciseLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        let mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        return mapView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.close.image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        print(GMSServices.openSourceLicenseInfo())
        setupLocationManager()
    }
    
    override func setupUI() {
        view.addSubview(mapView)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.height.width.equalTo(40)
        }
        closeButton.imageView?.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
    }
    
    override func bind() {
        closeButton.rx.tap.bind { [weak self] in
            self?.coordinator?.closeMapView()
        }
        .disposed(by: disposeBag)
    }
    
    func setupLocationManager() {
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        placesClient = GMSPlacesClient.shared()
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
            print("Location: \(location)")

            let zoomLevel = preciseLocationZoomLevel
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: zoomLevel)
        
              mapView.animate(to: camera)
    }
}
