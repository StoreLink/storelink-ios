//
//  MapCollectionViewCell.swift
//  Storelink
//
//  Created by Akysh Akan on 14.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {
    
    var storageItem: StorageItem? {
        didSet {
//            if let imageURL = URL(string: storageItem?.image ?? "") {
//                imageView.sd_setImage(with: imageURL)
//            } else {
//                imageView.image = nil
//            }
            if let image = ImageSaver.loadImageFromDiskWith(fileName: storageItem?.image ?? "") {
                imageView.image = image
            } else {
                imageView.image = nil
            }
            titleLabel.text = storageItem?.name
            priceLabel.text = StringUtils.textWithSymbol(text: String(storageItem?.price ?? 0), symbol: GlobalConstants.tgm)
            sizeLabel.text = StringUtils.textWithSymbol(text: String(storageItem?.size ?? 0), symbol: GlobalConstants.m)
            timeLabel.text = storageItem?.availableTime
        }
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let sizeLabel: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.size.image
        label.titleFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.spacing = 5
        return label
    }()
    
    private let timeLabel: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.clock.image
        label.titleFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.spacing = 5
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(roundedView)
        roundedView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
            $0.bottom.right.equalToSuperview().offset(-20)
        }
        
        roundedView.layer.shadowRadius = 10
        roundedView.layer.shadowOffset = .zero
        roundedView.layer.shadowOpacity = 0.5
        roundedView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        roundedView.layer.masksToBounds = false
        
        [imageView, titleLabel, sizeLabel, timeLabel, priceLabel].forEach {
            roundedView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-5)
        }
        
        sizeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(imageView.snp.right).offset(10)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(sizeLabel.snp.centerY)
            $0.left.equalTo(sizeLabel.snp.right).offset(15)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(sizeLabel.snp.bottom).offset(15)
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-5)
        }
    }
}
