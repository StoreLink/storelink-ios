//
//  MainButton.swift
//  Storelink
//
//  Created by Акан Акиш on 28.01.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class MainButton: BaseButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Colors.darkTeal.color : Colors.teal.color
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleColor = .white
        titleFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        backgroundColor = Colors.teal.color
        cornerRadius = 5
    }
}
