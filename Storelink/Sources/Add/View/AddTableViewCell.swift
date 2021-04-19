//
//  AddTableViewCell.swift
//  Storelink
//
//  Created by Акан Акиш on 18.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class AddTableViewCell: UITableViewCell {
    
    var addItem: AddItem? {
        didSet {
            addImageView.image = addItem?.image.withRenderingMode(.alwaysTemplate)
            titleLabel.text = addItem?.title
        }
    }
    
    private let addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = Colors.teal.color
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        contentView.backgroundColor = highlighted ? UIColor.lightGray.withAlphaComponent(0.3) : .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        [addImageView, titleLabel].forEach {
            addSubview($0)
        }
        
        addImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-10)
            $0.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(addImageView.snp.centerY)
            $0.left.equalTo(addImageView.snp.right).offset(15)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}
