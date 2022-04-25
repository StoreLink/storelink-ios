//
//  BaseButton.swift
//  Storelink
//
//  Created by Акан Акиш on 28.01.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

open class BaseButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? buttonColor?.shade(.dark) : buttonColor
        }
    }

    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    public var titleColor: UIColor? {
        didSet {
            setTitleColor(titleColor, for: .normal)
        }
    }

    public var titleFont: UIFont? {
        didSet {
            titleLabel?.font = titleFont
        }
    }

    public var buttonColor: UIColor? {
        didSet {
            backgroundColor = buttonColor
        }
    }

    public var borderColor: UIColor = .clear {
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

    public var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
