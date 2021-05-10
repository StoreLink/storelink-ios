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
    
    private lazy var mapView: MapView = {
        let mapView = MapView(labelIsHidden: true)
        mapView.setCameraPosition(withLatitude: 43.240887, longitude: 76.929203)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.zoomLevel = preciseLocationZoomLevel
        return mapView
    }()
    
    private let closeButton: CustomNavigationBarButton = .init(image: Assets.close.image)

    override func viewDidLoad() {
        super.viewDidLoad()

//        print(GMSServices.openSourceLicenseInfo())
        setupLocationManager()
    }
    
    override func setupUI() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.equalToSuperview().offset(20)
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
