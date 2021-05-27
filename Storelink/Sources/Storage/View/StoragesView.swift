//
//  StoragesView.swift
//  Storelink
//
//  Created by Акан Акиш on 11.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class StoragesView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.coloredStorage.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't have added storage"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
        }
    }

}
