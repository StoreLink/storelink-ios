//
//  StorageLocationViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 11.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class StorageLocationViewController: InitialViewController {
    private let latitude: Double
    private let longitude: Double

    private lazy var mapView: MapView = {
        let mapView = MapView(labelIsHidden: true)
        mapView.heroID = "map"
        return mapView
    }()

    private let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Done"
        return button
    }()

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    @available(*, unavailable)
    required convenience init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func setupUI() {
        setNavigationRightBarButtonItem()
        mapView.setCameraPosition(withLatitude: latitude, longitude: longitude)
        mapView.setSingleMarker(withLatitude: latitude, longitude: longitude)
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
