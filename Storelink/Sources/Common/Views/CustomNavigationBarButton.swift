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
            backgroundColor = isHighlighted ? UIColor.white.shade(.dark) : .white
        }
    }

    init(image: UIImage) {
        super.init(frame: .zero)
        setupUI(with: image)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(with image: UIImage) {
        setImage(image, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 20

        snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }
}
