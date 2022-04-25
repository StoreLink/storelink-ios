//
//  ProfilePopupViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/25/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

final class ProfilePopupViewController: InitialViewController {
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?

    var coordinator: ProfileFlow?

    private let topHandleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()

    private let closeButton: BaseButton = {
        let button = BaseButton()
        button.setImage(Assets.close.image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = .systemGray
        button.buttonColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.loginOrRegister
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.loginToManageAccount
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let loginButton = MainButton(title: Strings.login)

    private let signupButton = SecondaryButton(title: Strings.signup)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        let swipeDownGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
        view.addGestureRecognizer(swipeDownGesture)
    }

    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
    }

    override func setupUI() {
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 270)

        [topHandleView, closeButton, titleLabel, descriptionLabel, loginButton, signupButton].forEach {
            view.addSubview($0)
        }

        topHandleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(4)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topHandleView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }

        closeButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalToSuperview().offset(-30)
        }

        closeButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(45)
        }

        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.height.equalTo(45)
        }
    }

    override func bind() {
        closeButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

        loginButton.rx.tap.bind { [weak self] in
            self?.coordinator?.showLoginView()
        }.disposed(by: disposeBag)

        signupButton.rx.tap.bind { [weak self] in
            self?.coordinator?.showSignupView()
        }.disposed(by: disposeBag)
    }

    @objc private func swipeDownGestureAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }

        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 700 {
                dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
