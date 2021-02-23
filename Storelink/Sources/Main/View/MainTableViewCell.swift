//
//  MainTableViewCell.swift
//  Storelink
//
//  Created by Акан Акиш on 18.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var storageItem: StorageItem? {
        didSet {
            titleLabel.text = storageItem?.title
            descriptionLabel.text = storageItem?.description
            locationLabel.text = storageItem?.location
            priceLabel.text = String(storageItem?.price ?? 0)
        }
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = .zero
//        view.layer.shadowRadius = 5
//        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
//        view.layer.shouldRasterize = true
//        view.layer.rasterizationScale = UIScreen.main.scale
        return view
    }()
    
    private let storageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.location.image
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(16)
        }
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let priceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.money.image
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(16)
        }
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(roundedView)
        
        roundedView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        [storageImageView, titleLabel, descriptionLabel].forEach {
            roundedView.addSubview($0)
        }
        
        storageImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(storageImageView.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        let locationStackView = createStackView(views: [locationImageView, locationLabel])
        roundedView.addSubview(locationStackView)
        
        locationStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview()
        }
        
        let priceStackView = createStackView(views: [priceImageView, priceLabel])
        roundedView.addSubview(priceStackView)
        
        priceStackView.snp.makeConstraints {
            $0.top.equalTo(locationStackView.snp.bottom).offset(5)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func createStackView(views: [UIView]) -> UIView {
        let collectionView = UIStackView(arrangedSubviews: views)
        collectionView.axis = .horizontal
        collectionView.spacing = 5
        collectionView.alignment = .center
        collectionView.distribution = .fill
        return collectionView
    }
}
