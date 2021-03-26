//
//  DividerView.swift
//  Storelink
//
//  Created by Акан Акиш on 24.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class DividerView: UIView {

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .lightGray
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0.5)
        NSLayoutConstraint.activate([heightConstraint])
    }
}
