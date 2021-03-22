//
//  LabelWithBackgroundView.swift
//  Storelink
//
//  Created by Акан Акиш on 18.03.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class LabelWithBackgroundView: UIView {
    
    var text: String? = nil {
        didSet {
            label.text = text?.uppercased()
        }
    }

    let backgroundView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        blurEffectView.layer.cornerRadius = 5
        blurEffectView.layer.masksToBounds = true
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [backgroundView, label].forEach {
            addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(7)
            $0.right.equalToSuperview().offset(-7)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
