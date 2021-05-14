//
//  MapViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 24.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps
import GooglePlaces

final class MapViewController: InitialViewController {
    
    enum Constants {
        static let cellIdentifier = "cellId"
    }
    
    var coordinator: MainCoordinator?
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    private var placesClient: GMSPlacesClient!
    private var preciseLocationZoomLevel: Float = 15.0
    private var dataSource: BehaviorRelay<[StorageItem]> = .init(value: [])
    
    private lazy var mapView: MapView = {
        let mapView = MapView(labelIsHidden: true)
        mapView.setCameraPosition(withLatitude: 43.240887, longitude: 76.929203)
        mapView.settings.myLocationButton = false
        mapView.isMyLocationEnabled = true
        mapView.zoomLevel = preciseLocationZoomLevel
        return mapView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width, height: 150)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let closeButton: CustomNavigationBarButton = .init(image: Assets.close.image)
    
    init(storages: [StorageItem]) {
        dataSource.accept(storages)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(190)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    override func bind() {
        closeButton.rx.tap.bind { [weak self] in
            self?.coordinator?.closeMapView()
        }
        .disposed(by: disposeBag)
        
        dataSource
            .bind(to: collectionView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: MapCollectionViewCell.self)) { _, model, cell in
                cell.storageItem = model
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
