//
//  ScrollViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/23/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit
import SnapKit

class ScrollViewController: InitialViewController {
    
    // MARK: - UI Elements
    
    var _scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let _contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let _contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        setupScrollView()
        setupContentView()
        setupContentStackView()
    }
    
    // MARK: - Methods
    
    func addView(view: UIView) {
        _contentStackView.addArrangedSubview(view)
    }
    
    func addSpaceView(withSpacing spacing: CGFloat) {
        let spaceView = UIView()
        _contentStackView.addArrangedSubview(spaceView)
        spaceView.snp.makeConstraints {
            $0.height.equalTo(spacing)
        }
    }
    
    private func setupScrollView() {
        view.addSubview(_scrollView)
        _scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        _scrollView.addSubview(_contentView)
        _contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupContentStackView() {
        _contentView.addSubview(_contentStackView)
        _contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
    }

}
