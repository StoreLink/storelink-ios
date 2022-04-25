//
//  ItemTableViewCell.swift
//  Storelink
//
//  Created by Акан Акиш on 28.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    var item: Item? {
        didSet {
            if let image = ImageSaver.loadImageFromDiskWith(fileName: item?.image ?? "") {
                itemImageView.image = image
            } else {
                itemImageView.image = nil
            }
            titleLabel.text = item?.name
            descriptionLabel.text = item?.description
            sizeLabel.text = StringUtils.textWithSymbol(text: String(item?.size ?? 0), symbol: GlobalConstants.m)
            countLabel.text = String(item?.count ?? 0)
            publishDateLabel.text = "Today " + String(item?.createdDate.suffix(9) ?? "")
        }
    }

    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()

    private let itemImageView: UIImageView = {
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

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
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

    private let countLabel: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.count.image
        label.titleFont = UIFont.systemFont(ofSize: 13, weight: .regular)
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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }

    func setupUI() {
        addSubview(roundedView)
        roundedView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }

        roundedView.layer.shadowRadius = 10

        [itemImageView, titleLabel, descriptionLabel, sizeLabel, countLabel, publishDateLabel].forEach {
            roundedView.addSubview($0)
        }

        itemImageView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.top.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(itemImageView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-5)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.left.equalTo(itemImageView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-5)
        }

        sizeLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.left.equalTo(itemImageView.snp.right).offset(10)
        }

        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(sizeLabel.snp.centerY)
            $0.left.equalTo(sizeLabel.snp.right).offset(15)
        }

        publishDateLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
