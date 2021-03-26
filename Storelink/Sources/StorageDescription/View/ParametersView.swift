//
//  ParametersView.swift
//  Storelink
//
//  Created by Акан Акиш on 25.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class ParametersView: UIView {
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func addParameter(parameter: String, value: String) {
        let parameterLabel = UILabel()
        parameterLabel.text = parameter
        parameterLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        parameterLabel.textAlignment = .left
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        valueLabel.textColor = .gray
        valueLabel.textAlignment = .right
        
        let stackView = UIStackView(arrangedSubviews: [parameterLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        contentStackView.addArrangedSubview(stackView)
    }
    
}
