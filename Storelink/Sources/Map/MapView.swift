//
//  MapView.swift
//  Storelink
//
//  Created by Акан Акиш on 01.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift
import RxCocoa

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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGesture)
        
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
    
    func addMarker(withLatitude: Double, longitude: Double) {
        marker.position = CLLocationCoordinate2D(latitude: withLatitude, longitude: longitude)
        marker.map = self
    }
}
