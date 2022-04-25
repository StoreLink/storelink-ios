//
//  SelectLocationMapViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 08.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import GoogleMaps
import UIKit

class SelectLocationMapViewController: InitialViewController {
    var updateLocation: ((Double, Double) -> Void)?

    private lazy var mapView: MapView = {
        let mapView = MapView(labelIsHidden: true)
        mapView.setCameraPosition(withLatitude: 43.240887, longitude: 76.929203)
        mapView.delegate = self
        return mapView
    }()

    private let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Done"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    override func bind() {
        doneButton.rx.tap.bind { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }

    func setNavigationRightBarButtonItem() {
        navigationItem.rightBarButtonItem = doneButton
    }
}

extension SelectLocationMapViewController: GMSMapViewDelegate {
    func mapView(_: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.setSingleMarker(withLatitude: coordinate.latitude, longitude: coordinate.longitude)
        updateLocation?(coordinate.latitude, coordinate.longitude)
        setNavigationRightBarButtonItem()
    }
}
