//
//  SecondaryButton.swift
//  Storelink
//
//  Created by Акан Акиш on 29.01.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class SecondaryButton: BaseButton {
    
    override var isHighlighted: Bool {
        didSet {
            self.titleColor = isHighlighted ? Colors.darkTeal.color : Colors.teal.color
            self.borderColor = isHighlighted ? Colors.darkTeal.color : Colors.teal.color
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleColor = Colors.teal.color
        titleFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        backgroundColor = .white
        borderWidth = 1
        cornerRadius = 5
        borderColor = Colors.teal.color
    }
}
