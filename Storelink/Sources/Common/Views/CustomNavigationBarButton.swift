//
//  CustomNavigationBarButton.swift
//  Storelink
//
//  Created by Акан Акиш on 12.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class CustomNavigationBarButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor.white.shade(.dark) : .white
        }
    }

    init(image: UIImage) {
        super.init(frame: .zero)
        setupUI(with: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(with image: UIImage) {
        setImage(image, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 20
        
        snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
        
        imageView?.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
    }
    
}
