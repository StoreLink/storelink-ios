//
//  BaseButton.swift
//  Storelink
//
//  Created by Акан Акиш on 28.01.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

open class BaseButton: UIButton {
    
    public var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    public var titleColor: UIColor? {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    public var titleFont: UIFont? {
        didSet {
            self.titleLabel?.font = titleFont
        }
    }
    
    public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    private (set) lazy var heightConstraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: 45)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        heightConstraint.isActive = true
    }
}
