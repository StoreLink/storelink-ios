//
//  MapView.swift
//  Storelink
//
//  Created by Акан Акиш on 01.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import GoogleMaps
import RxCocoa
import RxSwift
import UIKit

protocol MapViewDelegate: class {
    func didTapMapView()
}

final class MapView: GMSMapView {
    weak var mapDelegate: MapViewDelegate?
    private var marker: GMSMarker = .init()
    private var labelIsHidden: Bool

    private let clickLabel: LabelWithBackgroundView = {
        let label = LabelWithBackgroundView()
        label.text = "Click to open"
        return label
    }()

    var zoomLevel: Float = 14.0

    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    init(labelIsHidden: Bool = false) {
        self.labelIsHidden = labelIsHidden
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        addGestureRecognizer(tapGesture)

        if !labelIsHidden {
            addSubview(clickLabel)
            clickLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-10)
            }
        }
    }

    // Gesture Recognizer
    @objc func didTapView() {
        mapDelegate?.didTapMapView()
    }

    func disableGestures() {
        settings.scrollGestures = false
        settings.zoomGestures = false
        settings.tiltGestures = false
        settings.rotateGestures = false
    }

    func setCameraPosition(withLatitude: Double, longitude: Double) {
        camera = GMSCameraPosition.camera(withLatitude: withLatitude, longitude: longitude, zoom: zoomLevel)
    }

    func setSingleMarker(withLatitude: Double, longitude: Double) {
        marker.position = CLLocationCoordinate2D(latitude: withLatitude, longitude: longitude)
        marker.map = self
    }

    func addMarker(withLatitude: Double, longitude: Double) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: withLatitude, longitude: longitude))
        marker.map = self
    }
}
