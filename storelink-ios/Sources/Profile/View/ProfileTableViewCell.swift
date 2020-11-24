//
//  ProfileTableViewCell.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/24/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var profile: ProfileCellModel? {
        didSet {
            nameLabel.text = profile?.name
            iconImageView.image = profile?.image
        }
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    private let nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.rightArrow.image
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [iconImageView, nameLabel, nextImageView].forEach {
            addSubview($0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.height.equalTo(25)
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(iconImageView.snp.right).offset(10)
            $0.centerY.equalTo(iconImageView)
            $0.right.equalToSuperview()
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.equalTo(20)
        }
    }
    
}
