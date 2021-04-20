//
//  MainTableViewCell.swift
//  Storelink
//
//  Created by Акан Акиш on 18.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import SDWebImage

final class MainTableViewCell: UITableViewCell {
    
    var storageItem: StorageItem? {
        didSet {
            if let imageURL = URL(string: storageItem?.image ?? "") {
                storageImageView.sd_setImage(with: imageURL)
            } else {
                storageImageView.image = nil
            }
            storageImageView.heroID = String(storageItem?.id ?? 0)
            typeLabel.text = storageItem?.type
            titleLabel.text = storageItem?.name
            priceLabel.text = StringUtils.textWithSymbol(text: String(storageItem?.price ?? 0), symbol: GlobalConstants.tgm)
            locationLabel.text = storageItem?.location
            sizeLabel.text = StringUtils.textWithSymbol(text: String(storageItem?.size ?? 0), symbol: GlobalConstants.m)
            timeLabel.text = storageItem?.availableTime
            publishDateLabel.text = storageItem?.createdDate
        }
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let typeLabel: LabelWithBackgroundView = {
        let label = LabelWithBackgroundView()
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    private let locationLabel: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.location.image
        label.titleFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.titleColor = UIColor.gray
        label.spacing = 3
        return label
    }()
    
    private let sizeLabel: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.size.image
        label.titleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.spacing = 5
        return label
    }()
    
    private let timeLabel: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.clock.image
        label.titleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.spacing = 5
        return label
    }()
    
    private let publishDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        roundedView.backgroundColor = highlighted ? UIColor.lightGray.withAlphaComponent(0.3) : .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(roundedView)
        
        roundedView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        [storageImageView, titleLabel, priceLabel, locationLabel, sizeLabel, timeLabel, publishDateLabel].forEach {
            roundedView.addSubview($0)
        }
        
        storageImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        storageImageView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(storageImageView.snp.bottom).offset(10)
            $0.left.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(5)
            $0.right.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        sizeLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(sizeLabel.snp.centerY)
            $0.left.equalTo(sizeLabel.snp.right).offset(15)
        }
        
        publishDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(sizeLabel.snp.centerY)
            $0.left.greaterThanOrEqualTo(timeLabel.snp.right)
            $0.right.equalToSuperview()
        }
    }
}
