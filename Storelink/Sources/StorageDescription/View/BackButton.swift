//
//  BackButton.swift
//  Storelink
//
//  Created by Акан Акиш on 23.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class BackButton: UIButton {
    
    var color: UIColor = .white {
        didSet {
            backgroundColor = color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? color.shade(.dark) : color
        }
    }

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setImage(Assets.back.image, for: .normal)
        backgroundColor = color
        layer.cornerRadius = 10
        setupShadow()
        frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        imageView?.snp.makeConstraints {
            $0.size.equalTo(20)
        }
    }
    
    func setupShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 35, height: 35)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func hideShadows() {
        color = .clear
        layer.shadowOpacity = 0
    }
    
    func showShadows() {
        color = .white
        layer.shadowOpacity = 0.5
    }
}
