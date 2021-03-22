//
//  LabelWithLeftImageView.swift
//  Storelink
//
//  Created by Акан Акиш on 14.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class LabelWithLeftImageView: UIView {
    
    var text: String? = nil {
        didSet {
            titleLabel.text = text
        }
    }
    
    var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var titleFont: UIFont = .systemFont(ofSize: 15) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    var imageSize: CGFloat = 20 {
        didSet {
            imageView.snp.makeConstraints {
                $0.height.width.equalTo(imageSize)
            }
        }
    }
    
    var spacing: CGFloat = 5 {
        didSet {
            contentStackView.spacing = spacing
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
