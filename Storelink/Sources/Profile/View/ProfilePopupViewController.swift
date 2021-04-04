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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.loginOrRegister
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.loginToManageAccount
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
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
            pointOrigin = self.view.frame.origin
        }
    }
    
    override func setupUI() {
        view.backgroundColor = .white
        [topHandleView, titleLabel, descriptionLabel, loginButton, signupButton].forEach {
            view.addSubview($0)
        }
        
        loginButton.activateConstraint()
        signupButton.activateConstraint()
        
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
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
    }
    
    override func bind() {
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
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 700 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
}
