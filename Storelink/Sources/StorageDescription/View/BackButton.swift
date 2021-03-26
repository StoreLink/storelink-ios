//
//  BackButton.swift
//  Storelink
//
//  Created by Акан Акиш on 23.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class BackButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white.shade(.dark) : .white
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
        backgroundColor = .white
        layer.cornerRadius = 10
        setupShadow()
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
    
}
