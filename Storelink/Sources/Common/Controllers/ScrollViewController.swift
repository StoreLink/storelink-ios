//
//  ScrollViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/23/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import SnapKit
import UIKit

class ScrollViewController: InitialViewController {
    // MARK: - UI Elements

    var _scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    let _containerView: UIView = {
        let view = UIView()
        return view
    }()

    let _stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        setupScrollView()
        setupContainerView()
        setupStackView()
    }

    // MARK: - Methods

    func addView(view: UIView) {
        _stackView.addArrangedSubview(view)
    }

    func addSpaceView(withSpacing spacing: CGFloat) {
        let spaceView = UIView()
        _stackView.addArrangedSubview(spaceView)
        spaceView.snp.makeConstraints {
            $0.height.equalTo(spacing)
        }
    }

    private func setupScrollView() {
        view.addSubview(_scrollView)
        _scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
    }

    private func setupContainerView() {
        _scrollView.addSubview(_containerView)
        _containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupStackView() {
        _containerView.addSubview(_stackView)
        _stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
    }
}
