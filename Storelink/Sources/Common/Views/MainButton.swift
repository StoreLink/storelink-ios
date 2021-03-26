//
//  MainButton.swift
//  Storelink
//
//  Created by Акан Акиш on 28.01.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class MainButton: BaseButton {
    
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
        buttonColor = Colors.teal.color
        cornerRadius = 5
    }
}
